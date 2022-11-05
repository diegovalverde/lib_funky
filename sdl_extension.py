
class SDLSetUserCtx:
    """
            Requires Simple2D to be installed.
            https://github.com/simple2d/simple2d

            """

    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):

        ctx = self.arg_list[0].eval()
        ref = ''
        if result is None:
            ref = 'TData'
            result = self.funk.emitter.create_anon()

        self.funk.emitter.code += """
        {ref} {result} = funky::sdl_set_user_ctx({ctx});
        """.format(result=result, ctx=ctx, ref=ref)
        return result


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


class SDLLine:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        pass
        #self.funk.emitter.sdl_line(self.funk, self.arg_list)

class S2DPoint:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        self.funk.emitter.s2d_point(self.arg_list)

class SDLRect:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        x = self.arg_list[0].eval()
        y = self.arg_list[1].eval()
        w = self.arg_list[2].eval()
        h = self.arg_list[3].eval()
        self.funk.emitter.code += """
        funky::sdl_rect({x}.i32, {y}.i32, {w}.i32, {h}.i32);
        """.format(x=x, y=y, w=w, h=h)

        return result

class SDLColor:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        r = self.arg_list[0].eval()
        g = self.arg_list[1].eval()
        b = self.arg_list[2].eval()

        self.funk.emitter.code += """
        funky::sdl_set_color({r}.i32, {g}.i32, {b}.i32);
        """.format(r=r, g=g, b=b)

        return result
