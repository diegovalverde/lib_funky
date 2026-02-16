class BytecodeError(Exception):
    def __init__(self, code, message):
        super().__init__("{}: {}".format(code, message))
        self.code = code
        self.message = message


def invalid_container(message):
    return BytecodeError("E4201", message)


def invalid_field(message):
    return BytecodeError("E4202", message)


def invalid_opcode(message):
    return BytecodeError("E4203", message)


def invalid_index(message):
    return BytecodeError("E4204", message)


def invalid_jump_target(message):
    return BytecodeError("E4205", message)


def strict_unknown_field(message):
    return BytecodeError("E4206", message)
