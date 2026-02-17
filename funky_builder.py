import os
import shlex
import subprocess
from .backends import BACKEND_OPTIMIZED, get_backend
from .host_effects import (
    collect_host_effect_libraries,
    parse_use_dependencies,
    requires_adapter,
    should_resolve_dependency,
)

link_with_sdl = False
active_effect_libraries = set()
funk_build_cwd=format(os.path.dirname(os.path.abspath(__file__)))


def set_cwd(path):
    global funk_build_cwd
    funk_build_cwd=path


def get_dependencies(src, include_paths=['.',os.getcwd()]):
    """
    :param include_paths: list of paths to the include search folders
    :param src: The text src file
    :return: list of paths to dependencies
    """
    dependencies = []
    global link_with_sdl, active_effect_libraries, funk_build_cwd
    active_effect_libraries |= collect_host_effect_libraries(src)
    link_with_sdl = requires_adapter(active_effect_libraries, "sdl2")

    for dep in parse_use_dependencies(src):
        if not should_resolve_dependency(dep):
            continue

        found = False
        for include_path in include_paths:
            dep_path = os.path.join(funk_build_cwd,include_path, '{}.f'.format(dep))

            if os.path.isfile(dep_path):
                dependencies.append(dep_path)
                found = True
                break

        if not found:
            print('-E- Could not find source file {}.f'.format(dep))
            print('-I- Include path ',include_paths)
            exit(1)

    return list(set(dependencies))


def get_file_base_name(src_path):
    ath, file_name = os.path.split(src_path)
    file_base_name, file_extension = os.path.splitext(file_name)
    return file_base_name


def exe_command(cmd):
    if isinstance(cmd, str):
        argv = shlex.split(cmd)
    else:
        argv = list(cmd)
    try:
        subprocess.run(argv, check=True)
    except Exception:
        print(" ".join(argv))
        exit(1)


def compile_source(src_path, build_path, backend_impl, debug=False, include_paths=None):
    try:
        if not os.path.isfile(src_path):
            src_path = os.path.join(os.getcwd(),src_path)

        with open(src_path, 'r') as my_file:
            src_text = my_file.read()

        return backend_impl.compile_source(
            src_path=src_path,
            src_text=src_text,
            build_path=build_path,
            debug=debug,
            exe_command=exe_command,
            include_paths=include_paths,
        )

    except IOError:
        print('-E- File not found \'{}\''.format(src_path))
        exit()


def link_sources(artifacts, build_path, src_path, backend_impl, include_paths=None):
    return backend_impl.link_sources(
        artifacts=artifacts,
        build_path=build_path,
        src_path=src_path,
        link_with_sdl=link_with_sdl,
        exe_command=exe_command,
        include_paths=include_paths,
    )


def build(src_path, include_paths, build_path, debug, backend=BACKEND_OPTIMIZED):
    try:
        global link_with_sdl, active_effect_libraries
        link_with_sdl = False
        active_effect_libraries = set()
        backend_impl = get_backend(backend)

        if not os.path.exists(build_path):
            os.mkdir(build_path)

        print('==== compiling ====')
        artifacts = compile_sources(src_path, include_paths, build_path, backend_impl, debug)

        print('==== linking ====')
        output = link_sources(artifacts, build_path, src_path, backend_impl, include_paths=include_paths)
        if output:
            print('==== output ====')
            print(output)

    except Exception as e:
        print(e.__str__())


def find_dependencies(src_path, include_paths):
    if not os.path.isfile(src_path):
        src_path = os.path.join(os.getcwd(), src_path)

    with open(src_path, 'r') as my_file:
        src_text = my_file.read()

    dependencies = get_dependencies(src_text, include_paths=include_paths)

    for dependency in dependencies:
        dependencies += find_dependencies(dependency, include_paths)
        dependencies = list(set(dependencies))

    return dependencies


def compile_sources(src_path, include_paths, build_path, backend_impl, debug=False):

    source_files = find_dependencies(src_path, include_paths)
    source_files.append(src_path)

    artifact_paths = []
    for src_file in source_files:
        artifact_path = backend_impl.artifact_path(build_path, src_file)
        if backend_impl.should_recompile(src_file, artifact_path):
            print('{} ... '.format(src_file), end='')
            artifact_path = compile_source(
                src_file,
                build_path=build_path,
                debug=debug,
                backend_impl=backend_impl,
                include_paths=include_paths,
            )
            print('Done')
        artifact_paths.append(artifact_path)

    return artifact_paths
