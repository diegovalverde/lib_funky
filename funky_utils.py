from lark.exceptions import UnexpectedEOF, UnexpectedToken, UnexpectedCharacters


def format_compilation_error(e):
    if isinstance(e, UnexpectedEOF):
        return 'Unexpected end of file'
    elif isinstance(e, UnexpectedToken) or isinstance(e, UnexpectedCharacters):
        return 'Syntax error row:{} col:{}\n'.format(e.line,  e.column)
    else:
        return e.__str__()
