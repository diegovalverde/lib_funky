import json

from .model import DecodedBytecode, FORMAT_V1_JSON


def encode(decoded):
    if not isinstance(decoded, DecodedBytecode):
        raise TypeError("encode expects DecodedBytecode")
    decoded.validate()
    payload = {
        "format": FORMAT_V1_JSON,
        "strings": list(decoded.strings),
        "functions": [_encode_function(fn) for fn in decoded.functions],
        "entry_fn": decoded.entry_fn,
    }
    return json.dumps(payload, indent=2, sort_keys=True) + "\n"


def _encode_function(fn):
    return {
        "name": fn.name,
        "arity": fn.arity,
        "captures": fn.captures,
        "code": [_encode_instruction(ins) for ins in fn.code],
    }


def _encode_instruction(ins):
    payload = {"op": ins.op.value}
    if ins.arg is not None:
        payload["arg"] = ins.arg
    if ins.argc is not None:
        payload["argc"] = ins.argc
    if ins.id is not None:
        payload["id"] = ins.id
    return payload
