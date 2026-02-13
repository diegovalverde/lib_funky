import json
import os

from ..optimized_compiler import OptimizedFunk
from .base import Backend


class BytecodeBackend(Backend):
    name = "bytecode"
    artifact_extension = ".fkb.json"

    def compile_source(self, src_path, src_text, build_path, debug, exe_command):
        # Reuse the existing front-end pipeline (parse + semantic checks),
        # then emit a backend-agnostic function manifest as bytecode seed.
        funk = OptimizedFunk(debug=debug)
        funk.compile(src_text)

        output_path = self.artifact_path(build_path, src_path)
        function_arity = {}
        function_clauses = {}
        for fn_name, fn_map in sorted(funk.function_map.items()):
            function_arity[fn_name] = fn_map.clauses[0].arity if len(fn_map.clauses) > 0 else 0
            function_clauses[fn_name] = len(fn_map.clauses)

        payload = {
            "format": "funk-bytecode-v0",
            "source": os.path.basename(src_path),
            "entrypoint": "main" if "main" in funk.known_functions else None,
            "functions": sorted(list(funk.known_functions)),
            "function_arity": function_arity,
            "function_clauses": function_clauses,
        }
        with open(output_path, "w") as f:
            json.dump(payload, f, indent=2, sort_keys=True)
            f.write("\n")
        return output_path

    def link_sources(self, artifacts, build_path, src_path, link_with_sdl, exe_command):
        program_name = os.path.splitext(os.path.basename(src_path))[0]
        bundle_path = os.path.join(build_path, "{}.fkb.bundle.json".format(program_name))
        payload = {
            "format": "funk-bytecode-bundle-v0",
            "entry_source": os.path.basename(src_path),
            "artifacts": sorted(list(set(artifacts))),
            "note": "Bytecode backend currently emits IR artifacts only; runtime execution is not wired yet.",
        }
        with open(bundle_path, "w") as f:
            json.dump(payload, f, indent=2, sort_keys=True)
            f.write("\n")
        return bundle_path
