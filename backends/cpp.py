import os
import shutil

from ..optimized_compiler import OptimizedFunk, OptimizedFunkI32
from .base import Backend


def get_sdl_flags():
    """
    Return (cflags, ldflags) for SDL2 if available via pkg-config or sdl2-config.
    """
    import subprocess
    for cmd in (["pkg-config", "--cflags", "sdl2"], ["sdl2-config", "--cflags"]):
        try:
            cflags = subprocess.check_output(cmd, text=True).strip()
            ldflags = ""
            if cmd[0] == "pkg-config":
                ldflags = subprocess.check_output(["pkg-config", "--libs", "sdl2"], text=True).strip()
            else:
                ldflags = subprocess.check_output(["sdl2-config", "--libs"], text=True).strip()
            return cflags, ldflags
        except Exception:
            continue
    return "", ""


class CppBackend(Backend):
    artifact_extension = ".o"

    def __init__(self, name, use_i32=False):
        self.name = name
        self.use_i32 = use_i32

    def _build_compiler(self, debug):
        if self.use_i32:
            return OptimizedFunkI32(debug=debug)
        return OptimizedFunk(debug=debug)

    def compile_source(self, src_path, src_text, build_path, debug, exe_command, include_paths=None):
        funk = self._build_compiler(debug=debug)
        funk.compile(src_text)

        file_base_name = os.path.splitext(os.path.basename(src_path))[0]
        cpp_path = os.path.join(build_path, "{}.cpp".format(file_base_name))
        object_path = os.path.join(build_path, "{}.o".format(file_base_name))

        funk.save_c(cpp_path)
        if shutil.which("clang-format"):
            cmd = (
                "clang-format -i --style=\"{{BasedOnStyle: llvm, IndentWidth: 8}}\" "
                "{cpp_path}"
            ).format(cpp_path=cpp_path)
            exe_command(cmd)

        cxx_std = "c++20"
        c_model_dir = "c_model_opt"
        extra_cxxflags = os.environ.get("FUNK_EXTRA_CXXFLAGS", "")
        cmd = (
            "clang++ -std={cxx_std} -g {extra_cxxflags} -c "
            "-I{build_path}/../funk/core/{c_model_dir}/ "
            "{cpp_path} -o {object_path}"
        ).format(
            build_path=build_path,
            cxx_std=cxx_std,
            c_model_dir=c_model_dir,
            extra_cxxflags=extra_cxxflags,
            cpp_path=cpp_path,
            object_path=object_path,
        )
        exe_command(cmd)
        return object_path

    def link_sources(self, artifacts, build_path, src_path, link_with_sdl, exe_command, include_paths=None):
        additional_link_flags = ""
        cxx_std = "c++20"
        extra_cxxflags = os.environ.get("FUNK_EXTRA_CXXFLAGS", "")
        c_model_dir = "c_model_opt"
        c_model_cpp = "funk_c_model_opt.cpp"
        sdl_cpp = "sdl_simple.cpp"

        if link_with_sdl:
            additional_link_flags += "-L/usr/local/lib -lSDL2 "
            sdl_cflags, sdl_ldflags = get_sdl_flags()
            if sdl_ldflags:
                additional_link_flags += " " + sdl_ldflags
            cmd = (
                "clang++ -g -c -std={cxx_std} {extra_cxxflags} {sdl_cflags} "
                "-I{build_path}/../funk/core/{c_model_dir}/ "
                "{build_path}/../funk/core/{c_model_dir}/{sdl_cpp} "
                "-o {build_path}/sdl_simple.o"
            ).format(
                build_path=build_path,
                sdl_cflags=sdl_cflags,
                cxx_std=cxx_std,
                c_model_dir=c_model_dir,
                sdl_cpp=sdl_cpp,
                extra_cxxflags=extra_cxxflags,
            )
            exe_command(cmd)
            artifacts = list(artifacts) + ["{}/{}".format(build_path, "sdl_simple.o")]

        cmd = (
            "clang++ -g -c -std={cxx_std} {extra_cxxflags} "
            "-I{build_path}/../funk/core/{c_model_dir}/ "
            "{build_path}/../funk/core/{c_model_dir}/{c_model_cpp} "
            "-o {build_path}/funk_c_model.o"
        ).format(
            build_path=build_path,
            cxx_std=cxx_std,
            c_model_dir=c_model_dir,
            c_model_cpp=c_model_cpp,
            extra_cxxflags=extra_cxxflags,
        )
        exe_command(cmd)

        file_name = os.path.basename(src_path)
        output = os.path.join(build_path, os.path.splitext(file_name)[0])
        cmd = (
            "clang++ -std={cxx_std} -g {extra_cxxflags} {additional_link_flags} "
            "{objects} {build_path}/funk_c_model.o "
            "-I{build_path}/../funk/core/{c_model_dir}/ -o {output}"
        ).format(
            build_path=build_path,
            output=output,
            objects=" ".join(artifacts),
            additional_link_flags=additional_link_flags,
            cxx_std=cxx_std,
            c_model_dir=c_model_dir,
            extra_cxxflags=extra_cxxflags,
        )
        exe_command(cmd)
        return output
