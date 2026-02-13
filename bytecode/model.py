from dataclasses import dataclass, field
from enum import Enum

from .errors import invalid_field, invalid_index, invalid_jump_target, invalid_opcode

FORMAT_V1_JSON = "funk-bytecode-v1-json"


class OpCode(str, Enum):
    PUSH_INT = "PUSH_INT"
    PUSH_FLOAT = "PUSH_FLOAT"
    PUSH_BOOL = "PUSH_BOOL"
    PUSH_STRING = "PUSH_STRING"
    PUSH_UNIT = "PUSH_UNIT"
    LOAD_LOCAL = "LOAD_LOCAL"
    STORE_LOCAL = "STORE_LOCAL"
    POP = "POP"
    JUMP = "JUMP"
    JUMP_IF_FALSE = "JUMP_IF_FALSE"
    CALL_BUILTIN = "CALL_BUILTIN"
    CALL_FN = "CALL_FN"
    CALL_INDIRECT = "CALL_INDIRECT"
    RETURN = "RETURN"
    TRAP = "TRAP"
    MK_LIST = "MK_LIST"
    GET_INDEX = "GET_INDEX"
    LEN = "LEN"


@dataclass
class Instruction:
    op: OpCode
    arg: object = None
    argc: int = None
    id: int = None


@dataclass
class FunctionBytecode:
    name: str
    arity: int
    captures: int
    code: list = field(default_factory=list)


@dataclass
class DecodedBytecode:
    strings: list
    functions: list
    entry_fn: int
    format: str = FORMAT_V1_JSON

    def validate(self):
        if self.format != FORMAT_V1_JSON:
            raise invalid_field("unsupported format '{}'".format(self.format))
        if not isinstance(self.strings, list):
            raise invalid_field("'strings' must be a list")
        for i, s in enumerate(self.strings):
            if not isinstance(s, str):
                raise invalid_field("strings[{}] must be a string".format(i))
        if not isinstance(self.functions, list) or len(self.functions) == 0:
            raise invalid_field("'functions' must be a non-empty list")
        if not isinstance(self.entry_fn, int) or self.entry_fn < 0:
            raise invalid_field("'entry_fn' must be a non-negative integer")
        if self.entry_fn >= len(self.functions):
            raise invalid_index("'entry_fn' out of bounds")
        for fn_idx, fn in enumerate(self.functions):
            _validate_function(self.strings, fn, fn_idx, len(self.functions))


def _validate_function(strings, fn, fn_idx, function_count):
    if not isinstance(fn.name, str) or fn.name == "":
        raise invalid_field("function[{}].name must be non-empty string".format(fn_idx))
    if not isinstance(fn.arity, int) or fn.arity < 0:
        raise invalid_field("function[{}].arity must be non-negative integer".format(fn_idx))
    if not isinstance(fn.captures, int) or fn.captures < 0:
        raise invalid_field("function[{}].captures must be non-negative integer".format(fn_idx))
    if not isinstance(fn.code, list):
        raise invalid_field("function[{}].code must be a list".format(fn_idx))

    for ip, ins in enumerate(fn.code):
        if not isinstance(ins, Instruction):
            raise invalid_field("function[{}].code[{}] invalid instruction".format(fn_idx, ip))
        if not isinstance(ins.op, OpCode):
            raise invalid_opcode("unknown opcode at function {}, ip {}".format(fn_idx, ip))
        _validate_instruction_operands(strings, ins, fn.code, ip, function_count)


def _validate_instruction_operands(strings, ins, code, ip, function_count):
    no_operand = {OpCode.PUSH_UNIT, OpCode.POP, OpCode.RETURN, OpCode.GET_INDEX, OpCode.LEN}
    if ins.op in no_operand:
        return

    if ins.op in {OpCode.PUSH_INT}:
        if not isinstance(ins.arg, int):
            raise invalid_field("PUSH_INT expects integer arg")
        return

    if ins.op in {OpCode.PUSH_FLOAT}:
        if not isinstance(ins.arg, (int, float)):
            raise invalid_field("PUSH_FLOAT expects numeric arg")
        return

    if ins.op in {OpCode.PUSH_BOOL}:
        if not isinstance(ins.arg, bool):
            raise invalid_field("PUSH_BOOL expects bool arg")
        return

    if ins.op in {OpCode.PUSH_STRING, OpCode.TRAP}:
        if not isinstance(ins.arg, int) or ins.arg < 0:
            raise invalid_field("{} expects non-negative integer arg".format(ins.op.value))
        if ins.arg >= len(strings):
            raise invalid_index("{} string index out of bounds".format(ins.op.value))
        return

    if ins.op in {OpCode.LOAD_LOCAL, OpCode.STORE_LOCAL}:
        if not isinstance(ins.arg, int) or ins.arg < 0:
            raise invalid_field("{} expects non-negative integer arg".format(ins.op.value))
        return

    if ins.op in {OpCode.JUMP, OpCode.JUMP_IF_FALSE}:
        if not isinstance(ins.arg, int) or ins.arg < 0:
            raise invalid_field("{} expects non-negative integer arg".format(ins.op.value))
        if ins.arg > len(code):
            raise invalid_jump_target("{} target out of bounds".format(ins.op.value))
        return

    if ins.op == OpCode.CALL_BUILTIN:
        if not isinstance(ins.id, int) or not isinstance(ins.argc, int):
            raise invalid_field("CALL_BUILTIN expects integer 'id' and 'argc'")
        if ins.id < 0 or ins.argc < 0:
            raise invalid_field("CALL_BUILTIN expects non-negative 'id' and 'argc'")
        return

    if ins.op == OpCode.CALL_FN:
        if not isinstance(ins.arg, int) or not isinstance(ins.argc, int):
            raise invalid_field("CALL_FN expects integer 'arg' (fn id) and 'argc'")
        if ins.arg < 0 or ins.argc < 0:
            raise invalid_field("CALL_FN expects non-negative 'arg' and 'argc'")
        if ins.arg >= function_count:
            raise invalid_index("CALL_FN function id out of bounds")
        return

    if ins.op == OpCode.CALL_INDIRECT:
        if not isinstance(ins.argc, int):
            raise invalid_field("CALL_INDIRECT expects integer 'argc'")
        if ins.argc < 0:
            raise invalid_field("CALL_INDIRECT expects non-negative 'argc'")
        return

    if ins.op == OpCode.MK_LIST:
        if not isinstance(ins.argc, int) or ins.argc < 0:
            raise invalid_field("MK_LIST expects non-negative integer 'argc'")
        return

    raise invalid_opcode("unsupported opcode '{}'".format(ins.op.value))
