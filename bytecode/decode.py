import json

from .errors import invalid_container, invalid_field, strict_unknown_field
from .model import DecodedBytecode, FunctionBytecode, Instruction, OpCode


TOP_LEVEL_FIELDS = {"format", "strings", "functions", "entry_fn"}
FUNCTION_FIELDS = {"name", "arity", "captures", "code"}
INSTRUCTION_FIELDS = {"op", "arg", "argc", "id"}


def decode(text, strict=False):
    try:
        payload = json.loads(text)
    except Exception as exc:
        raise invalid_container("invalid JSON container: {}".format(exc))

    if not isinstance(payload, dict):
        raise invalid_container("top-level bytecode payload must be an object")

    if strict:
        unknown = set(payload.keys()) - TOP_LEVEL_FIELDS
        if unknown:
            raise strict_unknown_field("unknown top-level field(s): {}".format(sorted(unknown)))

    strings = payload.get("strings")
    functions = payload.get("functions")
    entry_fn = payload.get("entry_fn")
    fmt = payload.get("format")

    decoded = DecodedBytecode(
        strings=strings,
        functions=[_decode_function(fn, strict) for fn in _expect_list(functions, "functions")],
        entry_fn=entry_fn,
        format=fmt,
    )
    decoded.validate()
    return decoded


def _decode_function(payload, strict):
    if not isinstance(payload, dict):
        raise invalid_field("function payload must be an object")
    if strict:
        unknown = set(payload.keys()) - FUNCTION_FIELDS
        if unknown:
            raise strict_unknown_field("unknown function field(s): {}".format(sorted(unknown)))
    return FunctionBytecode(
        name=payload.get("name"),
        arity=payload.get("arity"),
        captures=payload.get("captures"),
        code=[_decode_instruction(ins, strict) for ins in _expect_list(payload.get("code"), "function.code")],
    )


def _decode_instruction(payload, strict):
    if not isinstance(payload, dict):
        raise invalid_field("instruction payload must be an object")
    if strict:
        unknown = set(payload.keys()) - INSTRUCTION_FIELDS
        if unknown:
            raise strict_unknown_field("unknown instruction field(s): {}".format(sorted(unknown)))

    op_raw = payload.get("op")
    if not isinstance(op_raw, str):
        raise invalid_field("instruction 'op' must be a string")
    try:
        op = OpCode(op_raw)
    except Exception:
        raise invalid_field("unknown instruction opcode '{}'".format(op_raw))

    return Instruction(
        op=op,
        arg=payload.get("arg"),
        argc=payload.get("argc"),
        id=payload.get("id"),
    )


def _expect_list(value, field_name):
    if not isinstance(value, list):
        raise invalid_field("'{}' must be a list".format(field_name))
    return value
