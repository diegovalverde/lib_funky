; ModuleID = 'funk/core/c_model/funk_sdl.c'
source_filename = "funk/core/c_model/funk_sdl.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.16.0"

%struct.SDL_Renderer = type opaque
%struct.SDL_Window = type opaque
%struct.tnode = type { i32, i32, %struct.tpool*, %struct.tdimensions, %struct.tsiblings }
%struct.tpool = type { [250000 x %struct.tdata], i32, i8 }
%struct.tdata = type { i32, i8, %union.data_type }
%union.data_type = type { double }
%struct.tdimensions = type { i32, i32 }
%struct.tsiblings = type { i32, i32 }
%struct.SDL_Rect = type { i32, i32, i32, i32 }
%struct.sdl_context = type { %struct.tnode }
%union.SDL_Event = type { %struct.SDL_TouchFingerEvent, [8 x i8] }
%struct.SDL_TouchFingerEvent = type { i32, i32, i64, i64, float, float, float, float, float }

@renderer = global %struct.SDL_Renderer* null, align 8
@window = global %struct.SDL_Window* null, align 8
@stop_render = global i32 0, align 4
@bg_color = global [3 x i32] [i32 100, i32 100, i32 100], align 4
@g_sdl_user_global_state = common global %struct.tnode zeroinitializer, align 8
@__FUNCTION__.sdl_set_color = private unnamed_addr constant [14 x i8] c"sdl_set_color\00", align 1
@__FUNCTION__.sdl_rect = private unnamed_addr constant [9 x i8] c"sdl_rect\00", align 1
@__FUNCTION__.sdl_point = private unnamed_addr constant [10 x i8] c"sdl_point\00", align 1
@__FUNCTION__.sdl_line = private unnamed_addr constant [9 x i8] c"sdl_line\00", align 1
@.str = private unnamed_addr constant [25 x i8] c"-I- Initializing SDL 2D\0A\00", align 1
@.str.1 = private unnamed_addr constant [28 x i8] c"Couldn't initialize SDL: %s\00", align 1
@.str.2 = private unnamed_addr constant [40 x i8] c"Couldn't create window and renderer: %s\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @set_sdl_user_global_state(%struct.tnode*) #0 {
  %2 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %2, align 8
  %3 = load %struct.tnode*, %struct.tnode** %2, align 8
  call void @funk_copy_node(%struct.tnode* @g_sdl_user_global_state, %struct.tnode* %3)
  ret void
}

declare void @funk_copy_node(%struct.tnode*, %struct.tnode*) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @sdl_set_color(%struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  store %struct.tnode* %0, %struct.tnode** %4, align 8
  store %struct.tnode* %1, %struct.tnode** %5, align 8
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %7 = load %struct.SDL_Renderer*, %struct.SDL_Renderer** @renderer, align 8
  %8 = load %struct.tnode*, %struct.tnode** %4, align 8
  %9 = call %struct.tdata* @get_node(%struct.tnode* %8, i32 0, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @__FUNCTION__.sdl_set_color, i64 0, i64 0), i32 35, i32 1)
  %10 = getelementptr inbounds %struct.tdata, %struct.tdata* %9, i32 0, i32 2
  %11 = bitcast %union.data_type* %10 to i32*
  %12 = load i32, i32* %11, align 8
  %13 = trunc i32 %12 to i8
  %14 = load %struct.tnode*, %struct.tnode** %5, align 8
  %15 = call %struct.tdata* @get_node(%struct.tnode* %14, i32 0, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @__FUNCTION__.sdl_set_color, i64 0, i64 0), i32 36, i32 1)
  %16 = getelementptr inbounds %struct.tdata, %struct.tdata* %15, i32 0, i32 2
  %17 = bitcast %union.data_type* %16 to i32*
  %18 = load i32, i32* %17, align 8
  %19 = trunc i32 %18 to i8
  %20 = load %struct.tnode*, %struct.tnode** %6, align 8
  %21 = call %struct.tdata* @get_node(%struct.tnode* %20, i32 0, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @__FUNCTION__.sdl_set_color, i64 0, i64 0), i32 37, i32 1)
  %22 = getelementptr inbounds %struct.tdata, %struct.tdata* %21, i32 0, i32 2
  %23 = bitcast %union.data_type* %22 to i32*
  %24 = load i32, i32* %23, align 8
  %25 = trunc i32 %24 to i8
  %26 = call i32 @SDL_SetRenderDrawColor(%struct.SDL_Renderer* %7, i8 zeroext %13, i8 zeroext %19, i8 zeroext %25, i8 zeroext -1)
  ret void
}

declare i32 @SDL_SetRenderDrawColor(%struct.SDL_Renderer*, i8 zeroext, i8 zeroext, i8 zeroext, i8 zeroext) #1

declare %struct.tdata* @get_node(%struct.tnode*, i32, i8*, i32, i32) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @sdl_rect(%struct.tnode*, %struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca %struct.SDL_Rect, align 4
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store %struct.tnode* %2, %struct.tnode** %7, align 8
  store %struct.tnode* %3, %struct.tnode** %8, align 8
  %10 = load %struct.tnode*, %struct.tnode** %5, align 8
  %11 = call %struct.tdata* @get_node(%struct.tnode* %10, i32 0, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.sdl_rect, i64 0, i64 0), i32 42, i32 1)
  %12 = getelementptr inbounds %struct.tdata, %struct.tdata* %11, i32 0, i32 2
  %13 = bitcast %union.data_type* %12 to i32*
  %14 = load i32, i32* %13, align 8
  %15 = getelementptr inbounds %struct.SDL_Rect, %struct.SDL_Rect* %9, i32 0, i32 0
  store i32 %14, i32* %15, align 4
  %16 = load %struct.tnode*, %struct.tnode** %6, align 8
  %17 = call %struct.tdata* @get_node(%struct.tnode* %16, i32 0, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.sdl_rect, i64 0, i64 0), i32 43, i32 1)
  %18 = getelementptr inbounds %struct.tdata, %struct.tdata* %17, i32 0, i32 2
  %19 = bitcast %union.data_type* %18 to i32*
  %20 = load i32, i32* %19, align 8
  %21 = getelementptr inbounds %struct.SDL_Rect, %struct.SDL_Rect* %9, i32 0, i32 1
  store i32 %20, i32* %21, align 4
  %22 = load %struct.tnode*, %struct.tnode** %7, align 8
  %23 = call %struct.tdata* @get_node(%struct.tnode* %22, i32 0, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.sdl_rect, i64 0, i64 0), i32 44, i32 1)
  %24 = getelementptr inbounds %struct.tdata, %struct.tdata* %23, i32 0, i32 2
  %25 = bitcast %union.data_type* %24 to i32*
  %26 = load i32, i32* %25, align 8
  %27 = getelementptr inbounds %struct.SDL_Rect, %struct.SDL_Rect* %9, i32 0, i32 2
  store i32 %26, i32* %27, align 4
  %28 = load %struct.tnode*, %struct.tnode** %8, align 8
  %29 = call %struct.tdata* @get_node(%struct.tnode* %28, i32 0, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.sdl_rect, i64 0, i64 0), i32 45, i32 1)
  %30 = getelementptr inbounds %struct.tdata, %struct.tdata* %29, i32 0, i32 2
  %31 = bitcast %union.data_type* %30 to i32*
  %32 = load i32, i32* %31, align 8
  %33 = getelementptr inbounds %struct.SDL_Rect, %struct.SDL_Rect* %9, i32 0, i32 3
  store i32 %32, i32* %33, align 4
  %34 = load %struct.SDL_Renderer*, %struct.SDL_Renderer** @renderer, align 8
  %35 = call i32 @SDL_RenderFillRect(%struct.SDL_Renderer* %34, %struct.SDL_Rect* %9)
  ret void
}

declare i32 @SDL_RenderFillRect(%struct.SDL_Renderer*, %struct.SDL_Rect*) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @sdl_point(%struct.tnode*, %struct.tnode*) #0 {
  %3 = alloca %struct.tnode*, align 8
  %4 = alloca %struct.tnode*, align 8
  %5 = alloca %struct.tdata*, align 8
  %6 = alloca %struct.tdata*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %3, align 8
  store %struct.tnode* %1, %struct.tnode** %4, align 8
  %9 = load %struct.tnode*, %struct.tnode** %3, align 8
  %10 = call %struct.tdata* @get_node(%struct.tnode* %9, i32 0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.sdl_point, i64 0, i64 0), i32 51, i32 1)
  store %struct.tdata* %10, %struct.tdata** %5, align 8
  %11 = load %struct.tnode*, %struct.tnode** %4, align 8
  %12 = call %struct.tdata* @get_node(%struct.tnode* %11, i32 0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @__FUNCTION__.sdl_point, i64 0, i64 0), i32 52, i32 1)
  store %struct.tdata* %12, %struct.tdata** %6, align 8
  %13 = load %struct.tdata*, %struct.tdata** %5, align 8
  %14 = getelementptr inbounds %struct.tdata, %struct.tdata* %13, i32 0, i32 0
  %15 = load i32, i32* %14, align 8
  %16 = icmp eq i32 %15, 1
  br i1 %16, label %17, label %22

17:                                               ; preds = %2
  %18 = load %struct.tdata*, %struct.tdata** %5, align 8
  %19 = getelementptr inbounds %struct.tdata, %struct.tdata* %18, i32 0, i32 2
  %20 = bitcast %union.data_type* %19 to i32*
  %21 = load i32, i32* %20, align 8
  br label %28

22:                                               ; preds = %2
  %23 = load %struct.tdata*, %struct.tdata** %5, align 8
  %24 = getelementptr inbounds %struct.tdata, %struct.tdata* %23, i32 0, i32 2
  %25 = bitcast %union.data_type* %24 to double*
  %26 = load double, double* %25, align 8
  %27 = fptosi double %26 to i32
  br label %28

28:                                               ; preds = %22, %17
  %29 = phi i32 [ %21, %17 ], [ %27, %22 ]
  store i32 %29, i32* %7, align 4
  %30 = load %struct.tdata*, %struct.tdata** %6, align 8
  %31 = getelementptr inbounds %struct.tdata, %struct.tdata* %30, i32 0, i32 0
  %32 = load i32, i32* %31, align 8
  %33 = icmp eq i32 %32, 1
  br i1 %33, label %34, label %39

34:                                               ; preds = %28
  %35 = load %struct.tdata*, %struct.tdata** %6, align 8
  %36 = getelementptr inbounds %struct.tdata, %struct.tdata* %35, i32 0, i32 2
  %37 = bitcast %union.data_type* %36 to i32*
  %38 = load i32, i32* %37, align 8
  br label %45

39:                                               ; preds = %28
  %40 = load %struct.tdata*, %struct.tdata** %6, align 8
  %41 = getelementptr inbounds %struct.tdata, %struct.tdata* %40, i32 0, i32 2
  %42 = bitcast %union.data_type* %41 to double*
  %43 = load double, double* %42, align 8
  %44 = fptosi double %43 to i32
  br label %45

45:                                               ; preds = %39, %34
  %46 = phi i32 [ %38, %34 ], [ %44, %39 ]
  store i32 %46, i32* %8, align 4
  %47 = load %struct.SDL_Renderer*, %struct.SDL_Renderer** @renderer, align 8
  %48 = call i32 @SDL_SetRenderDrawColor(%struct.SDL_Renderer* %47, i8 zeroext 0, i8 zeroext -1, i8 zeroext 0, i8 zeroext -1)
  %49 = load %struct.SDL_Renderer*, %struct.SDL_Renderer** @renderer, align 8
  %50 = load i32, i32* %7, align 4
  %51 = load i32, i32* %8, align 4
  %52 = call i32 @SDL_RenderDrawPoint(%struct.SDL_Renderer* %49, i32 %50, i32 %51)
  %53 = load %struct.SDL_Renderer*, %struct.SDL_Renderer** @renderer, align 8
  %54 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @bg_color, i64 0, i64 0), align 4
  %55 = trunc i32 %54 to i8
  %56 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @bg_color, i64 0, i64 1), align 4
  %57 = trunc i32 %56 to i8
  %58 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @bg_color, i64 0, i64 2), align 4
  %59 = trunc i32 %58 to i8
  %60 = call i32 @SDL_SetRenderDrawColor(%struct.SDL_Renderer* %53, i8 zeroext %55, i8 zeroext %57, i8 zeroext %59, i8 zeroext -1)
  ret void
}

declare i32 @SDL_RenderDrawPoint(%struct.SDL_Renderer*, i32, i32) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @sdl_line(%struct.tnode*, %struct.tnode*, %struct.tnode*, %struct.tnode*) #0 {
  %5 = alloca %struct.tnode*, align 8
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca %struct.tnode*, align 8
  %8 = alloca %struct.tnode*, align 8
  %9 = alloca %struct.tdata*, align 8
  %10 = alloca %struct.tdata*, align 8
  %11 = alloca %struct.tdata*, align 8
  %12 = alloca %struct.tdata*, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  store %struct.tnode* %0, %struct.tnode** %5, align 8
  store %struct.tnode* %1, %struct.tnode** %6, align 8
  store %struct.tnode* %2, %struct.tnode** %7, align 8
  store %struct.tnode* %3, %struct.tnode** %8, align 8
  %17 = load %struct.tnode*, %struct.tnode** %5, align 8
  %18 = call %struct.tdata* @get_node(%struct.tnode* %17, i32 0, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.sdl_line, i64 0, i64 0), i32 66, i32 1)
  store %struct.tdata* %18, %struct.tdata** %9, align 8
  %19 = load %struct.tnode*, %struct.tnode** %6, align 8
  %20 = call %struct.tdata* @get_node(%struct.tnode* %19, i32 0, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.sdl_line, i64 0, i64 0), i32 67, i32 1)
  store %struct.tdata* %20, %struct.tdata** %10, align 8
  %21 = load %struct.tnode*, %struct.tnode** %7, align 8
  %22 = call %struct.tdata* @get_node(%struct.tnode* %21, i32 0, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.sdl_line, i64 0, i64 0), i32 68, i32 1)
  store %struct.tdata* %22, %struct.tdata** %11, align 8
  %23 = load %struct.tnode*, %struct.tnode** %8, align 8
  %24 = call %struct.tdata* @get_node(%struct.tnode* %23, i32 0, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @__FUNCTION__.sdl_line, i64 0, i64 0), i32 69, i32 1)
  store %struct.tdata* %24, %struct.tdata** %12, align 8
  %25 = load %struct.tdata*, %struct.tdata** %9, align 8
  %26 = getelementptr inbounds %struct.tdata, %struct.tdata* %25, i32 0, i32 0
  %27 = load i32, i32* %26, align 8
  %28 = icmp eq i32 %27, 1
  br i1 %28, label %29, label %34

29:                                               ; preds = %4
  %30 = load %struct.tdata*, %struct.tdata** %9, align 8
  %31 = getelementptr inbounds %struct.tdata, %struct.tdata* %30, i32 0, i32 2
  %32 = bitcast %union.data_type* %31 to i32*
  %33 = load i32, i32* %32, align 8
  br label %40

34:                                               ; preds = %4
  %35 = load %struct.tdata*, %struct.tdata** %9, align 8
  %36 = getelementptr inbounds %struct.tdata, %struct.tdata* %35, i32 0, i32 2
  %37 = bitcast %union.data_type* %36 to double*
  %38 = load double, double* %37, align 8
  %39 = fptosi double %38 to i32
  br label %40

40:                                               ; preds = %34, %29
  %41 = phi i32 [ %33, %29 ], [ %39, %34 ]
  store i32 %41, i32* %13, align 4
  %42 = load %struct.tdata*, %struct.tdata** %10, align 8
  %43 = getelementptr inbounds %struct.tdata, %struct.tdata* %42, i32 0, i32 0
  %44 = load i32, i32* %43, align 8
  %45 = icmp eq i32 %44, 1
  br i1 %45, label %46, label %51

46:                                               ; preds = %40
  %47 = load %struct.tdata*, %struct.tdata** %10, align 8
  %48 = getelementptr inbounds %struct.tdata, %struct.tdata* %47, i32 0, i32 2
  %49 = bitcast %union.data_type* %48 to i32*
  %50 = load i32, i32* %49, align 8
  br label %57

51:                                               ; preds = %40
  %52 = load %struct.tdata*, %struct.tdata** %10, align 8
  %53 = getelementptr inbounds %struct.tdata, %struct.tdata* %52, i32 0, i32 2
  %54 = bitcast %union.data_type* %53 to double*
  %55 = load double, double* %54, align 8
  %56 = fptosi double %55 to i32
  br label %57

57:                                               ; preds = %51, %46
  %58 = phi i32 [ %50, %46 ], [ %56, %51 ]
  store i32 %58, i32* %14, align 4
  %59 = load %struct.tdata*, %struct.tdata** %11, align 8
  %60 = getelementptr inbounds %struct.tdata, %struct.tdata* %59, i32 0, i32 0
  %61 = load i32, i32* %60, align 8
  %62 = icmp eq i32 %61, 1
  br i1 %62, label %63, label %68

63:                                               ; preds = %57
  %64 = load %struct.tdata*, %struct.tdata** %11, align 8
  %65 = getelementptr inbounds %struct.tdata, %struct.tdata* %64, i32 0, i32 2
  %66 = bitcast %union.data_type* %65 to i32*
  %67 = load i32, i32* %66, align 8
  br label %74

68:                                               ; preds = %57
  %69 = load %struct.tdata*, %struct.tdata** %11, align 8
  %70 = getelementptr inbounds %struct.tdata, %struct.tdata* %69, i32 0, i32 2
  %71 = bitcast %union.data_type* %70 to double*
  %72 = load double, double* %71, align 8
  %73 = fptosi double %72 to i32
  br label %74

74:                                               ; preds = %68, %63
  %75 = phi i32 [ %67, %63 ], [ %73, %68 ]
  store i32 %75, i32* %15, align 4
  %76 = load %struct.tdata*, %struct.tdata** %12, align 8
  %77 = getelementptr inbounds %struct.tdata, %struct.tdata* %76, i32 0, i32 0
  %78 = load i32, i32* %77, align 8
  %79 = icmp eq i32 %78, 1
  br i1 %79, label %80, label %85

80:                                               ; preds = %74
  %81 = load %struct.tdata*, %struct.tdata** %12, align 8
  %82 = getelementptr inbounds %struct.tdata, %struct.tdata* %81, i32 0, i32 2
  %83 = bitcast %union.data_type* %82 to i32*
  %84 = load i32, i32* %83, align 8
  br label %91

85:                                               ; preds = %74
  %86 = load %struct.tdata*, %struct.tdata** %12, align 8
  %87 = getelementptr inbounds %struct.tdata, %struct.tdata* %86, i32 0, i32 2
  %88 = bitcast %union.data_type* %87 to double*
  %89 = load double, double* %88, align 8
  %90 = fptosi double %89 to i32
  br label %91

91:                                               ; preds = %85, %80
  %92 = phi i32 [ %84, %80 ], [ %90, %85 ]
  store i32 %92, i32* %16, align 4
  %93 = load %struct.SDL_Renderer*, %struct.SDL_Renderer** @renderer, align 8
  %94 = call i32 @SDL_SetRenderDrawColor(%struct.SDL_Renderer* %93, i8 zeroext 0, i8 zeroext -1, i8 zeroext 0, i8 zeroext -1)
  %95 = load %struct.SDL_Renderer*, %struct.SDL_Renderer** @renderer, align 8
  %96 = load i32, i32* %13, align 4
  %97 = load i32, i32* %14, align 4
  %98 = load i32, i32* %15, align 4
  %99 = load i32, i32* %16, align 4
  %100 = call i32 @SDL_RenderDrawLine(%struct.SDL_Renderer* %95, i32 %96, i32 %97, i32 %98, i32 %99)
  %101 = load %struct.SDL_Renderer*, %struct.SDL_Renderer** @renderer, align 8
  %102 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @bg_color, i64 0, i64 0), align 4
  %103 = trunc i32 %102 to i8
  %104 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @bg_color, i64 0, i64 1), align 4
  %105 = trunc i32 %104 to i8
  %106 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @bg_color, i64 0, i64 2), align 4
  %107 = trunc i32 %106 to i8
  %108 = call i32 @SDL_SetRenderDrawColor(%struct.SDL_Renderer* %101, i8 zeroext %103, i8 zeroext %105, i8 zeroext %107, i8 zeroext -1)
  ret void
}

declare i32 @SDL_RenderDrawLine(%struct.SDL_Renderer*, i32, i32, i32, i32) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @sdl_render_loop(i8*) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca %struct.tnode, align 8
  store i8* %0, i8** %2, align 8
  %4 = load %struct.SDL_Renderer*, %struct.SDL_Renderer** @renderer, align 8
  %5 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @bg_color, i64 0, i64 0), align 4
  %6 = trunc i32 %5 to i8
  %7 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @bg_color, i64 0, i64 1), align 4
  %8 = trunc i32 %7 to i8
  %9 = load i32, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @bg_color, i64 0, i64 2), align 4
  %10 = trunc i32 %9 to i8
  %11 = call i32 @SDL_SetRenderDrawColor(%struct.SDL_Renderer* %4, i8 zeroext %6, i8 zeroext %8, i8 zeroext %10, i8 zeroext -1)
  %12 = load %struct.SDL_Renderer*, %struct.SDL_Renderer** @renderer, align 8
  %13 = call i32 @SDL_RenderClear(%struct.SDL_Renderer* %12)
  call void @funk_create_int_scalar(i32 1, %struct.tnode* %3, i32 0)
  call void @sdl_render(%struct.tnode* %3, i32 1, %struct.tnode* @g_sdl_user_global_state)
  %14 = load %struct.SDL_Renderer*, %struct.SDL_Renderer** @renderer, align 8
  call void @SDL_RenderPresent(%struct.SDL_Renderer* %14)
  ret void
}

declare i32 @SDL_RenderClear(%struct.SDL_Renderer*) #1

declare void @funk_create_int_scalar(i32, %struct.tnode*, i32) #1

declare void @sdl_render(%struct.tnode*, i32, %struct.tnode*) #1

declare void @SDL_RenderPresent(%struct.SDL_Renderer*) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @funk_sdl_create_window(i32, i32, %struct.tnode*) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca %struct.tnode*, align 8
  %7 = alloca %struct.sdl_context, align 8
  %8 = alloca %union.SDL_Event, align 8
  store i32 %0, i32* %4, align 4
  store i32 %1, i32* %5, align 4
  store %struct.tnode* %2, %struct.tnode** %6, align 8
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str, i64 0, i64 0))
  %10 = call i32 @SDL_Init(i32 32)
  %11 = icmp slt i32 %10, 0
  br i1 %11, label %12, label %14

12:                                               ; preds = %3
  %13 = call i8* @SDL_GetError()
  call void (i32, i8*, ...) @SDL_LogError(i32 0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.1, i64 0, i64 0), i8* %13)
  br label %14

14:                                               ; preds = %12, %3
  %15 = load i32, i32* %4, align 4
  %16 = load i32, i32* %5, align 4
  %17 = call i32 @SDL_CreateWindowAndRenderer(i32 %15, i32 %16, i32 32, %struct.SDL_Window** @window, %struct.SDL_Renderer** @renderer)
  %18 = icmp ne i32 %17, 0
  br i1 %18, label %19, label %21

19:                                               ; preds = %14
  %20 = call i8* @SDL_GetError()
  call void (i32, i8*, ...) @SDL_LogError(i32 0, i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.2, i64 0, i64 0), i8* %20)
  br label %21

21:                                               ; preds = %19, %14
  %22 = load %struct.tnode*, %struct.tnode** %6, align 8
  call void @funk_copy_node(%struct.tnode* @g_sdl_user_global_state, %struct.tnode* %22)
  br label %23

23:                                               ; preds = %21, %29
  %24 = call i32 @SDL_PollEvent(%union.SDL_Event* %8)
  %25 = bitcast %union.SDL_Event* %8 to i32*
  %26 = load i32, i32* %25, align 8
  %27 = icmp eq i32 %26, 256
  br i1 %27, label %28, label %29

28:                                               ; preds = %23
  br label %31

29:                                               ; preds = %23
  %30 = bitcast %struct.sdl_context* %7 to i8*
  call void @sdl_render_loop(i8* %30)
  br label %23

31:                                               ; preds = %28
  %32 = load %struct.SDL_Renderer*, %struct.SDL_Renderer** @renderer, align 8
  call void @SDL_DestroyRenderer(%struct.SDL_Renderer* %32)
  %33 = load %struct.SDL_Window*, %struct.SDL_Window** @window, align 8
  call void @SDL_DestroyWindow(%struct.SDL_Window* %33)
  call void @SDL_Quit()
  ret void
}

declare i32 @printf(i8*, ...) #1

declare i32 @SDL_Init(i32) #1

declare void @SDL_LogError(i32, i8*, ...) #1

declare i8* @SDL_GetError() #1

declare i32 @SDL_CreateWindowAndRenderer(i32, i32, i32, %struct.SDL_Window**, %struct.SDL_Renderer**) #1

declare i32 @SDL_PollEvent(%union.SDL_Event*) #1

declare void @SDL_DestroyRenderer(%struct.SDL_Renderer*) #1

declare void @SDL_DestroyWindow(%struct.SDL_Window*) #1

declare void @SDL_Quit() #1

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 9.0.1 "}
