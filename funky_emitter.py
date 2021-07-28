class Emitter:
    def __init__(self):
        pass

    def emit(self):
        pass

    def allocate_result(self):
        pass

    def alloc_tnode(self, name, value, pool, data_type):
        pass

    def alloc_literal_list(self, name, lit_list, dimensions, pool, result=None):
        pass

    def create_list_of_regs(self, name, reg_list, dimensions, pool, result=None):
        pass

    def print_funk(self, funk, args):
        pass
