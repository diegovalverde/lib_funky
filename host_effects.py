import re


# Libraries in this map are host-effect entry points and not regular `.f` includes.
# `adapter` identifies the host-side implementation that should be linked/registered.
HOST_EFFECT_LIBRARIES = {
    "sdl_simple": {
        "adapter": "sdl2",
        "resolve_source": False,
    }
}


def parse_use_dependencies(src_text):
    deps = []
    for line in src_text.splitlines():
        match = re.findall(r"^ *\t*use +(.*)", line)
        if len(match) == 0:
            continue
        for dep in match[0].split(","):
            dep = dep.strip()
            if dep != "":
                deps.append(dep)
    return deps


def is_host_effect_library(dep_name):
    return dep_name in HOST_EFFECT_LIBRARIES


def should_resolve_dependency(dep_name):
    info = HOST_EFFECT_LIBRARIES.get(dep_name)
    if info is None:
        return True
    return bool(info.get("resolve_source", False))


def collect_host_effect_libraries(src_text):
    effects = set()
    for dep in parse_use_dependencies(src_text):
        if is_host_effect_library(dep):
            effects.add(dep)
    return effects


def requires_adapter(effect_libs, adapter):
    for lib in effect_libs:
        info = HOST_EFFECT_LIBRARIES.get(lib, {})
        if info.get("adapter") == adapter:
            return True
    return False
