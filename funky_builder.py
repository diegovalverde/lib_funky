import re
from .funky_compiler import Funk
import os

link_with_sdl = False
funk_build_cwd=format(os.path.dirname(os.path.abspath(__file__)))


def set_cwd(path):
    global funk_build_cwd
    funk_build_cwd=path


def get_depnames(src):
    # find the dependencies
    deps = []
    for line in src.splitlines():
        global link_with_sdl, funk_build_cwd
        match = re.findall('^ *\t*use +(.*)', line)
        if len(match) == 0:
            continue
        for dep in match[0].split(','):
            dep = dep.strip()
            deps.append(dep)

    return deps


def get_dependencies(src, include_paths=['.',os.getcwd()]):
    """
    :param include_paths: list of paths to the include search folders
    :param src: The text src file
    :return: list of paths to dependencies
    """
    dependencies = []
    for line in src.splitlines():
        global link_with_sdl, funk_build_cwd
        match = re.findall('^ *\t*use +(.*)', line)
        if len(match) == 0:
            continue
        for dep in match[0].split(','):
            dep = dep.strip()
            if dep == 'sdl_simple':
                link_with_sdl = True
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
    retval = os.system(cmd)
    if retval != 0:
        print(cmd)
        exit(1)


def call_clang_on_cpp_source(build_path, file_base_name):
    # apply clang format
    cmd = 'clang-format -i --style="{{BasedOnStyle: llvm, IndentWidth: 8}}" {path}/{file_base_path}.cpp'.format(
        path=build_path, file_base_path=file_base_name)
    exe_command(cmd)

    # compile
    cmd = 'clang++ -std=c++11 -g -c -I{build_path}/../funk/core/c_model/ {build_path}/{file_base_name}.cpp -o {build_path}/{file_base_name}.o'.format(
        build_path=build_path, file_base_name=file_base_name)
    exe_command(cmd)


def compile_source(src_path, build_path,  debug=False, mode='cpp'):
    try:
        funk = Funk(debug=debug, mode=mode)

        if not os.path.isfile(src_path):
            src_path = os.path.join(os.getcwd(),src_path)

        with open(src_path, 'r') as my_file:
            src_text = my_file.read()

        funk.compile(src_text)

        file_base_name = get_file_base_name(src_path)

        funk.save_c(os.path.join(build_path, '{file_base_name}.{mode}'.format(file_base_name=file_base_name, mode=mode)))

        if mode == 'cpp':
            call_clang_on_cpp_source(build_path, file_base_name)

    except IOError:
        print('-E- File not found \'{}\''.format(src_path))
        exit()


def link_sources(obj_list, build_path, src_path):
    additional_link_flags = ''
    if link_with_sdl:
        additional_link_flags += '-L/usr/local/lib -lSDL2 '
        cmd = 'clang++ -g -c -std=c++11 -I{build_path}/../funk/core/c_model/ {build_path}/../funk/core/c_model/sdl_simple.cpp -o {build_path}/sdl_simple.o'.format(
            build_path=build_path)
        exe_command(cmd)

        obj_list.append('{}/{}'.format(build_path, 'sdl_simple.o'))

    cmd = 'clang++ -g -c -std=c++11 -I{build_path}/../funk/core/c_model/ {build_path}/../funk/core/c_model/funk_c_model.cpp -o {build_path}/funk_c_model.o'.format(
        build_path=build_path)
    exe_command(cmd)

    _, file_name = os.path.split(src_path)
    output = os.path.join(build_path, os.path.splitext(file_name)[0])

    cmd = 'clang++ -std=c++11 -g {additional_link_flags} {objects} {build_path}/funk_c_model.o -I{build_path}/../funk/core/c_model/ -o {output}'.format(
        build_path=build_path, output=output, objects=' '.join(obj_list), additional_link_flags=additional_link_flags)
    exe_command(cmd)


def build(src_path, include_paths, build_path, debug, mode='cpp'):
    try:
        global link_with_sdl

        if not os.path.exists(build_path):
            os.mkdir(build_path)

        print('==== compiling ====')
        object_files = compile_sources(src_path, include_paths, build_path, debug=debug, mode=mode)

        if mode == 'cpp':
            print('==== linking ====')
            link_sources(object_files, build_path, src_path)

    except Exception as e:
        print(e.__str__())


def src_is_newer(src_path, build_path):
    _, file_name = os.path.split(src_path)
    obj_path = os.path.join(build_path, '{}.o'.format(os.path.splitext(file_name)[0]))

    if not os.path.exists(obj_path):
        return True

    obj_time = os.path.getmtime(obj_path)
    src_time = os.path.getmtime(src_path)

    return src_time > obj_time


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


def compile_sources(src_path, include_paths, build_path, debug=False, mode='cpp'):

    source_files = find_dependencies(src_path, include_paths)
    source_files.append(src_path)

    for src_file in source_files:
        if src_is_newer(src_file, build_path):
            print('{} ... '.format(src_file), end='')
            compile_source(src_file, build_path=build_path, debug=debug, mode=mode)
            print('Done')

    object_files = [os.path.join(build_path, '{}.o'.format(get_file_base_name(file))) for file in source_files]
    return object_files

