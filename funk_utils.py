import re
from lark import Lark
def formatCompilationError(e):
    
    return 'Syntax error row:{} col:{}\n'.format(e.line,  e.column)
