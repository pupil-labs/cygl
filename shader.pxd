cimport cgl as gl

cdef class Shader:
    cdef dict uniforms
    cdef object _vertex_code , _fragment_code
    cdef gl.GLuint handle
    cdef bint linked

    cdef _build_shader(self,const char * strings, shader_type)

    cdef _link(self)

    cpdef bind(self)

    cpdef unbind(self)

    cpdef uniformi(self, bytes name, vals)

    cpdef uniformf(self, bytes name, vals)

    cpdef uniform1f(self, bytes name,float val)

    cpdef uniform_matrixf(self, bytes name, float[:] mat)

    cdef _get_shader_info(self,gl.GLuint shader)

    cdef _get_program_info(self)
