#include <SDL2/SDL.h>
#if FUNK_BUILD_FOR_WEB
#include <emscripten.h>
#include <emscripten/html5.h>
#endif

#include "funk_c_model.h"


namespace funky {


class CRenderer{
    public:
    CRenderer(){}
        
    void Initialize(int w, int h){ 
        std::cout << "-I- Initializing SDL..." ;

        if (SDL_Init(SDL_INIT_VIDEO) < 0) {
            SDL_LogError(SDL_LOG_CATEGORY_APPLICATION, "Couldn't initialize SDL: %s", SDL_GetError());
        }
        if (SDL_CreateWindowAndRenderer(w, h, SDL_WINDOW_RESIZABLE, &window, &renderer)) {
            SDL_LogError(SDL_LOG_CATEGORY_APPLICATION, "Couldn't create window and renderer: %s", SDL_GetError());
        }
        std::cout << "done" <<std::endl;
    }
    ~CRenderer(){
        std::cout << "-I- Releasing SDL...";
        SDL_DestroyRenderer(renderer);
        SDL_DestroyWindow(window);
        SDL_Quit();
        std::cout << "done"  << std::endl;
    }

    SDL_Renderer *renderer = nullptr;
    SDL_Window *window = nullptr;
    int bg_color[3] = {100,100,100};
};

CRenderer sdl;


  struct sdl_context{
      TData user_data;
  } ctx;

  TData s2d_render( std::vector<TData> &);
//---------------------------------------------------------------------------------------------------
TData s2d_set_user_ctx(const TData & arg){
  ctx.user_data = arg;
  return TData(1);
}
//---------------------------------------------------------------------------------------------------
void s2d_render_loop(void *arg)
{
    SDL_SetRenderDrawColor(sdl.renderer, sdl.bg_color[0], sdl.bg_color[1], sdl.bg_color[2], 255);
    SDL_RenderClear(sdl.renderer);

    std::vector<TData> args = {ctx.user_data};
    TData result = funky::s2d_render( args );
   
    SDL_RenderPresent(sdl.renderer);
}
//---------------------------------------------------------------------------------------------------
void s2d_point( TData & x,  TData & y){
  
  int x_ = (x.type == funky_type::i32) ? x.i32 : static_cast<int>(x.d64);
  int y_ = (y.type == funky_type::i32) ? y.i32 : static_cast<int>(y.d64);

  SDL_SetRenderDrawColor(sdl.renderer, 0, 255, 0, 255);
  SDL_RenderDrawPoint(sdl.renderer, x_,y_);
  SDL_SetRenderDrawColor(sdl.renderer, sdl.bg_color[0], sdl.bg_color[1], sdl.bg_color[2], 255);

}
//---------------------------------------------------------------------------------------------------
void sdl_set_color(int r, int g, int b){
  SDL_SetRenderDrawColor(sdl.renderer,r,g,b,255);
    
}
//---------------------------------------------------------------------------------------------------
void sdl_rect(int x, int y, int w, int h){
  SDL_Rect r = {x,y,w,h};
  SDL_RenderFillRect(sdl.renderer, &r );
}
//---------------------------------------------------------------------------------------------------
TData s2d(std::vector<TData> & args){
    int w = args[0].i32;
    int h = args[1].i32;
    ctx.user_data = args[2];
    
    sdl.Initialize(w,h);

    SDL_Event event;
    while (1){
      SDL_PollEvent(&event);
      if (event.type == SDL_QUIT) {
            break;
      }
      s2d_render_loop((void*)&ctx);
    }
  
  return TData(1);
}
//---------------------------------------------------------------------------------------------------
} //namspace