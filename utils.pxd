

cdef class RGBA:
    cdef public float r,g,b,a

cpdef init()

cpdef draw_points(points,float size=*,RGBA color=*,float sharpness=*)

cpdef draw_polyline(verts,float width=*,RGBA color=*,line_type =*)
