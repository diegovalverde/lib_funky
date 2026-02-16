import os

from ..bytecode import BytecodeLowerer, encode, encode_binary
from ..host_effects import parse_use_dependencies, should_resolve_dependency
from ..optimized_compiler import OptimizedFunk
from .base import Backend


class BytecodeBackend(Backend):
    name = "bytecode"
    artifact_extension = ".fkb.json"

    def should_recompile(self, src_path, artifact_path):
        # Bytecode lowering is evolving rapidly; always rebuild to avoid
        # stale artifacts when backend logic changes independently of source mtimes.
        return True

    def _normalize_search_paths(self, src_path, include_paths):
        candidates = [os.path.dirname(os.path.abspath(src_path)), os.getcwd(), os.path.join(os.getcwd(), "stdlib")]
        for path in include_paths or []:
            if path is None:
                continue
            if os.path.isabs(path):
                candidates.append(path)
            else:
                candidates.append(os.path.abspath(path))
        out = []
        seen = set()
        for path in candidates:
            norm = os.path.abspath(path)
            if norm not in seen:
                seen.add(norm)
                out.append(norm)
        return out

    def _direct_dependencies(self, src_text):
        deps = []
        for dep in parse_use_dependencies(src_text):
            if not should_resolve_dependency(dep):
                continue
            deps.append(dep)
        return deps

    def _resolve_dep_path(self, dep_name, search_paths):
        target = "{}.f".format(dep_name)
        for root in search_paths:
            cand = os.path.join(root, target)
            if os.path.isfile(cand):
                return os.path.abspath(cand)
        raise RuntimeError("Could not find source file {} in include paths".format(target))

    def _collect_dependency_sources(self, src_path, src_text, search_paths):
        ordered_paths = []
        seen = set()

        def walk(path, text):
            for dep_name in self._direct_dependencies(text):
                dep_path = self._resolve_dep_path(dep_name, search_paths)
                if dep_path in seen:
                    continue
                seen.add(dep_path)
                with open(dep_path, "r") as f:
                    dep_text = f.read()
                walk(dep_path, dep_text)
                ordered_paths.append(dep_path)

        walk(src_path, src_text)
        return ordered_paths

    def compile_source(self, src_path, src_text, build_path, debug, exe_command, include_paths=None):
        # Reuse the existing front-end pipeline (parse + semantic checks),
        # then lower what we support and trap unsupported function bodies.
        # For bytecode we compile the source plus its `use` dependency closure
        # together so cross-file function calls resolve in one program graph.
        search_paths = self._normalize_search_paths(src_path, include_paths)
        dep_paths = self._collect_dependency_sources(src_path, src_text, search_paths)
        if dep_paths:
            dep_blobs = []
            for dep_path in dep_paths:
                with open(dep_path, "r") as f:
                    dep_blobs.append(f.read())
            combined_src = "\n\n".join(dep_blobs + [src_text])
        else:
            combined_src = src_text

        funk = OptimizedFunk(debug=debug)
        funk.compile(combined_src)

        output_path = self.artifact_path(build_path, src_path)
        payload = BytecodeLowerer(funk).lower_program()
        with open(output_path, "w") as f:
            f.write(encode(payload))
        binary_path = output_path[: -len(".json")] if output_path.endswith(".json") else output_path + ".fkb"
        with open(binary_path, "wb") as f:
            f.write(encode_binary(payload))
        return output_path

    def link_sources(self, artifacts, build_path, src_path, link_with_sdl, exe_command, include_paths=None):
        import json
        program_name = os.path.splitext(os.path.basename(src_path))[0]
        bundle_path = os.path.join(build_path, "{}.fkb.bundle.json".format(program_name))
        payload = {
            "format": "funk-bytecode-bundle-v1",
            "entry_source": os.path.basename(src_path),
            "artifacts": sorted(list(set(artifacts))),
            "note": "JSON (*.fkb.json) and binary (*.fkb) artifacts are emitted.",
        }
        with open(bundle_path, "w") as f:
            json.dump(payload, f, indent=2, sort_keys=True)
            f.write("\n")
        return bundle_path
