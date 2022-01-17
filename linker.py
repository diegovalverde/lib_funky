import re
from .funk import Funk
import os

link_with_sdl = False
dependency_satisfied = set()
link_targets = set()
funk_build_cwd=format(os.path.dirname(os.path.abspath(__file__)))
obj_list = []

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

    return dependencies


def get_file_base_name(src_path):
    ath, file_name = os.path.split(src_path)
    file_base_name, file_extension = os.path.splitext(file_name)
    return file_base_name


def compile_source(src_path, build_path, include_paths, debug=False):
    try:
        dependencies = []
        funk = Funk(debug=debug)

        if not os.path.isfile(src_path):
            src_path = os.path.join(os.getcwd(),src_path)

        with open(src_path, 'r') as my_file:
            src_text = my_file.read()

        funk.compile(src_text)

        file_base_name = get_file_base_name(src_path)

        funk.save_c(os.path.join(build_path, '{}.cpp'.format(file_base_name)))
        # apply clang format
        cmd ='clang-format -i --style="{{BasedOnStyle: llvm, IndentWidth: 8}}" {path}/{file_base_path}.cpp'.format(path=build_path,file_base_path=file_base_name)
        #print(cmd)
        os.system(cmd)

        # compile
        cmd = 'clang++ -std=c++11 -g -c -I{build_path}/../funk/core/c_model/ {build_path}/{file_base_name}.cpp -o {build_path}/{file_base_name}.o'.format(
            build_path=build_path, file_base_name=file_base_name)
        obj_list.append('{build_path}/{file_base_name}.o'.format(build_path=build_path,file_base_name=file_base_name))

        retval = os.system(cmd)
        if retval != 0:
            print(cmd)
            exit(1)

        print('{} -> {}/{}'.format('{}.f'.format(file_base_name), build_path,'{}.cpp'.format(file_base_name)))
        dependency_satisfied.add(src_path)
        link_targets.add(os.path.join(build_path,'{}.cpp'.format(file_base_name)))

        for dependency in get_dependencies(src_text, include_paths=include_paths):
            name = get_file_base_name(dependency)
            ll_path = os.path.join(build_path, '{}.cpp'.format(name))
            link_targets.add(ll_path)
            #if not os.path.isfile(ll_path) or os.path.getmtime(ll_path) < os.path.getmtime(dependency):
            dependencies.append(dependency)

        return dependencies

    except IOError:
        print('-E- File not found \'{}\''.format(src_path))
        exit()


def is_in_path_env(program):
    for path in os.environ["PATH"].split(os.pathsep):
        exe_file = os.path.join(path, program)
        if os.path.exists(exe_file):
            return True

    return False


def build(src_path, include_paths, build_path, debug):
    global link_with_sdl

    print('==== compiling ====')

    if not os.path.exists(build_path):
        os.mkdir(build_path)

    obj_list = build_source(src_path, include_paths, build_path, debug)

    additional_link_flags = ''
    if link_with_sdl:
        additional_link_flags += '-L/usr/local/lib -lSDL2 '
        cmd = 'clang++ -g -c -std=c++11 -I{build_path}/../funk/core/c_model/ {build_path}/../funk/core/c_model/sdl_simple.cpp -o {build_path}/sdl_simple.o'.format(
            build_path=build_path)

        retval = os.system(cmd)
        if retval != 0:
            print(cmd)
            exit(1)

        obj_list.append('{}/{}'.format(build_path,  'sdl_simple.o'))

    print('==== linking ====')
    cmd = 'clang++ -g -c -std=c++11 -I{build_path}/../funk/core/c_model/ {build_path}/../funk/core/c_model/funk_c_model.cpp -o {build_path}/funk_c_model.o'.format(
        build_path=build_path)

    retval = os.system(cmd)
    if retval != 0:
        print(cmd)
        exit(1)

    _, file_name = os.path.split(src_path)
    output = os.path.join(build_path, os.path.splitext(file_name)[0])

    cmd = 'clang++ -std=c++11 -g {additional_link_flags} {objects} {build_path}/funk_c_model.o -I{build_path}/../funk/core/c_model/ -o {output}.exe'.format(
        build_path=build_path, output=output, objects=' '.join(obj_list), additional_link_flags=additional_link_flags)

    retval = os.system(cmd)
    if retval != 0:
        print(cmd)
        exit(1)


def build_source(src_path, include_paths, build_path, debug=False):
    dependencies = compile_source(src_path, include_paths=include_paths,
                                  build_path=build_path, debug=debug)
    for dependency in dependencies:
        if dependency in dependency_satisfied:
            continue
        dependencies = build_source(dependency, include_paths=include_paths,
                     build_path=build_path, debug=debug)

    return obj_list
