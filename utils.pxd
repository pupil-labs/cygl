

cdef class RGBA:
    cdef public float r,g,b,a

cpdef init()

cpdef draw_polyline(verts,float thickness=*,RGBA color=*,line_type =*)
cpdef draw_polyline_norm(verts,float thickness=*,RGBA color=*,line_type =*)

cpdef draw_points(points,float size=*,RGBA color=*,float sharpness=*)
cpdef draw_points_norm(points,float size=*,RGBA color=*,float sharpness=*)

cdef class Render_Target:
    cdef fbo_tex_id

cpdef push_ortho(int w,int h)
cpdef pop_ortho()
