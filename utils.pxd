

cdef class RGBA:
    cdef public float r,g,b,a

cpdef init()

cpdef draw_polyline(verts,float thickness=*,RGBA color=*,line_type =*)
cpdef draw_polyline_norm(verts,float thickness=*,RGBA color=*,line_type =*)

cpdef draw_points(points,float size=*,RGBA color=*,float sharpness=*)
cpdef draw_points_norm(points,float size=*,RGBA color=*,float sharpness=*)

