cimport glew as gl

cdef class Shader:
    cdef dict uniforms
    cdef unicode _vertex_code, _fragment_code, _geometry_code
    cdef public gl.GLuint handle
    cdef bint linked

    cdef _build_shader(self, const char * strings, shader_type)

    cdef _link(self)

    cpdef bind(self)

    cpdef unbind(self)

    cpdef uniformi(self, unicode name, vals)

    cpdef uniformf(self, unicode name, vals)

    cpdef uniform1f(self, unicode name,float val)

    cpdef uniform1i(self, unicode name,int val)

    cpdef uniform_matrixf(self, unicode name, float[:] mat)

    cdef _get_shader_info(self,gl.GLuint shader)

    cdef _get_program_info(self)
