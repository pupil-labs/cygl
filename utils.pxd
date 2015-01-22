

cdef class RGBA:
    cdef public float r,g,b,a

cpdef init()

cpdef draw_points(points,float size=*,RGBA color=*,float sharpness=*)
