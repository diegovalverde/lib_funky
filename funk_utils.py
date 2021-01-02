import re
from lark import Lark
from lark.exceptions import UnexpectedEOF, UnexpectedToken
def formatCompilationError(e):
    if (isinstance(e, UnexpectedEOF)):
        return 'Unexpected end of file'
    elif (isinstance(e, Exception)):
        return e.__str__()
    else:
        return 'Syntax error row:{} col:{}\n'.format(e.line,  e.column)

