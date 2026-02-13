import struct

from .model import DecodedBytecode, OpCode


MAGIC = b"FKB1"

OPCODE_TO_BYTE = {
    OpCode.PUSH_INT: 0,
    OpCode.PUSH_FLOAT: 1,
    OpCode.PUSH_BOOL: 2,
    OpCode.PUSH_STRING: 3,
    OpCode.PUSH_UNIT: 4,
    OpCode.LOAD_LOCAL: 5,
    OpCode.STORE_LOCAL: 6,
    OpCode.POP: 7,
    OpCode.JUMP: 8,
    OpCode.JUMP_IF_FALSE: 9,
    OpCode.CALL_BUILTIN: 10,
    OpCode.CALL_FN: 11,
    OpCode.CALL_INDIRECT: 12,
    OpCode.RETURN: 13,
    OpCode.TRAP: 14,
    OpCode.MK_LIST: 15,
    OpCode.GET_INDEX: 16,
    OpCode.LEN: 17,
}

ARG_KIND_NONE = 0
ARG_KIND_INT = 1
ARG_KIND_FLOAT = 2
ARG_KIND_BOOL = 3


def encode_binary(decoded):
    if not isinstance(decoded, DecodedBytecode):
        raise TypeError("encode_binary expects DecodedBytecode")
    decoded.validate()

    out = bytearray()
    out.extend(MAGIC)
    out.extend(_u32(len(decoded.strings)))
    for s in decoded.strings:
        raw = s.encode("utf-8")
        out.extend(_u32(len(raw)))
        out.extend(raw)

    out.extend(_u32(len(decoded.functions)))
    for fn in decoded.functions:
        name_raw = fn.name.encode("utf-8")
        out.extend(_u32(len(name_raw)))
        out.extend(name_raw)
        out.extend(_u32(fn.arity))
        out.extend(_u32(fn.captures))
        out.extend(_u32(len(fn.code)))
        for ins in fn.code:
            out.extend(_u8(OPCODE_TO_BYTE[ins.op]))
            arg_kind, arg_payload = _encode_arg_payload(ins.arg)
            out.extend(_u8(arg_kind))
            out.extend(arg_payload)
            out.extend(_u8(ins.argc if ins.argc is not None else 255))
            out.extend(_u8(ins.id if ins.id is not None else 255))

    out.extend(_u32(decoded.entry_fn))
    return bytes(out)


def _encode_arg_payload(arg):
    if arg is None:
        return ARG_KIND_NONE, b""
    if isinstance(arg, bool):
        return ARG_KIND_BOOL, _u8(1 if arg else 0)
    if isinstance(arg, int):
        return ARG_KIND_INT, struct.pack("<q", arg)
    if isinstance(arg, float):
        return ARG_KIND_FLOAT, struct.pack("<d", arg)
    raise TypeError("unsupported instruction arg type '{}'".format(type(arg).__name__))


def _u8(v):
    return struct.pack("<B", v)


def _u32(v):
    return struct.pack("<I", v)
