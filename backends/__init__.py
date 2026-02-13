from .bytecode import BytecodeBackend
from .cpp import CppBackend

BACKEND_OPTIMIZED = "cpp20"
BACKEND_OPTIMIZED_I32 = "cpp20_i32"
BACKEND_BYTECODE = "bytecode"

_BACKEND_REGISTRY = {
    BACKEND_OPTIMIZED: CppBackend(name=BACKEND_OPTIMIZED, use_i32=False),
    BACKEND_OPTIMIZED_I32: CppBackend(name=BACKEND_OPTIMIZED_I32, use_i32=True),
    BACKEND_BYTECODE: BytecodeBackend(),
}


def get_backend(name):
    if name not in _BACKEND_REGISTRY:
        raise ValueError(
            "Unsupported backend '{}'. Available backends: {}".format(
                name, ", ".join(list_backends())
            )
        )
    return _BACKEND_REGISTRY[name]


def list_backends():
    return sorted(_BACKEND_REGISTRY.keys())
