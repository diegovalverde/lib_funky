
class S2DSetUserCtx:
    """
            Requires Simple2D to be installed.
            https://github.com/simple2d/simple2d

            """

    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        ctx = self.arg_list[0].eval()
        return self.funk.emitter.s2d_set_context(result, ctx)



class SDLRenderFunction:
    """
        Requires Simple2D to be installed.
        https://github.com/simple2d/simple2d

        """

    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        pass


class S2DLine:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        self.funk.emitter.s2d_line( self.arg_list)

class S2DPoint:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        self.funk.emitter.s2d_point(self.arg_list)

class S2DRect:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        x = self.arg_list[0].eval()
        y = self.arg_list[1].eval()
        w = self.arg_list[2].eval()
        h = self.arg_list[3].eval()

        return self.funk.emitter.s2d_rect(result,x,y,w,h)


class S2DColor:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        r = self.arg_list[0].eval()
        g = self.arg_list[1].eval()
        b = self.arg_list[2].eval()

        return self.funk.emitter.s2d_color(result,r,g,b)

