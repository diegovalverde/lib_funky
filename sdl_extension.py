
class SDLCreateWindow:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        w = self.arg_list[0].eval()
        h = self.arg_list[0].eval()
        user_data = self.funk.emitter.create_anon()

        self.funk.emitter.code += """
        {{
            TData {user_data};
            std::vector<TData> args{{ TData({w}), TData({h}), TData({user_data}) }};
            funky::sdl_simple(args);
        }}
        """.format(w=w, h=h, user_data=user_data)

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
        #self.funk.emitter.sdl_render_callback(self.funk, self.arg_list)

class SDLLine:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        pass
        #self.funk.emitter.sdl_line(self.funk, self.arg_list)

class SDLPoint:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        x = self.arg_list[0].eval()
        y = self.arg_list[1].eval()
        self.funk.emitter.code += """
        {{
           // std::cout << x << "," << y << std::endl;
            TData _x({x});
            TData _y({y});
            funky::sdl_point(_x, _y);
        }}
        """.format(x=x, y=y)
        #self.funk.emitter.sdl_point(self.funk, self.arg_list)

class SDLRect:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        pass
        #self.funk.emitter.sdl_rect(self.funk, self.arg_list)

class SDLColor:
    def __init__(self, funk, arg_list):
        self.funk = funk
        self.arg_list = arg_list

    def eval(self, result=None):
        pass
        #self.funk.emitter.sdl_set_color(self.funk, self.arg_list)
