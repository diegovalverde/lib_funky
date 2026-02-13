import os

from ..bytecode import BytecodeLowerer, encode
from ..optimized_compiler import OptimizedFunk
from .base import Backend


class BytecodeBackend(Backend):
    name = "bytecode"
    artifact_extension = ".fkb.json"

    def compile_source(self, src_path, src_text, build_path, debug, exe_command):
        # Reuse the existing front-end pipeline (parse + semantic checks),
        # then lower what we support and trap unsupported function bodies.
        funk = OptimizedFunk(debug=debug)
        funk.compile(src_text)

        output_path = self.artifact_path(build_path, src_path)
        payload = BytecodeLowerer(funk).lower_program()
        with open(output_path, "w") as f:
            f.write(encode(payload))
        return output_path

    def link_sources(self, artifacts, build_path, src_path, link_with_sdl, exe_command):
        import json
        program_name = os.path.splitext(os.path.basename(src_path))[0]
        bundle_path = os.path.join(build_path, "{}.fkb.bundle.json".format(program_name))
        payload = {
            "format": "funk-bytecode-bundle-v1",
            "entry_source": os.path.basename(src_path),
            "artifacts": sorted(list(set(artifacts))),
            "note": "Bytecode backend currently emits IR artifacts only; runtime execution is not wired yet.",
        }
        with open(bundle_path, "w") as f:
            json.dump(payload, f, indent=2, sort_keys=True)
            f.write("\n")
        return bundle_path
