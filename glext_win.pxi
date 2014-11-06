   # inclomplete  defines. This is hacky and should be done properly.

cdef extern from 'glext.h':
    enum: GL_INVALID_FRAMEBUFFER_OPERATION
    enum: GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING
    enum: GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE
    enum: GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE
    enum: GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE
    enum: GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE
    enum: GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE
    enum: GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE
    enum: GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE
    enum: GL_FRAMEBUFFER_DEFAULT
    enum: GL_FRAMEBUFFER_UNDEFINED
    enum: GL_DEPTH_STENCIL_ATTACHMENT
    enum: GL_MAX_RENDERBUFFER_SIZE
    enum: GL_DEPTH_STENCIL
    enum: GL_UNSIGNED_INT_24_8
    enum: GL_DEPTH24_STENCIL8
    enum: GL_TEXTURE_STENCIL_SIZE
    enum: GL_TEXTURE_RED_TYPE
    enum: GL_TEXTURE_GREEN_TYPE
    enum: GL_TEXTURE_BLUE_TYPE
    enum: GL_TEXTURE_ALPHA_TYPE
    enum: GL_TEXTURE_DEPTH_TYPE
    enum: GL_UNSIGNED_NORMALIZED
    enum: GL_FRAMEBUFFER_BINDING
    enum: GL_DRAW_FRAMEBUFFER_BINDING
    enum: GL_RENDERBUFFER_BINDING
    enum: GL_READ_FRAMEBUFFER
    enum: GL_DRAW_FRAMEBUFFER
    enum: GL_READ_FRAMEBUFFER_BINDING
    enum: GL_RENDERBUFFER_SAMPLES
    enum: GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE
    enum: GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME
    enum: GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL
    enum: GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE
    enum: GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER
    enum: GL_FRAMEBUFFER_COMPLETE
    enum: GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT
    enum: GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT
    enum: GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER
    enum: GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER
    enum: GL_FRAMEBUFFER_UNSUPPORTED
    enum: GL_MAX_COLOR_ATTACHMENTS
    enum: GL_COLOR_ATTACHMENT0
    enum: GL_COLOR_ATTACHMENT1
    enum: GL_COLOR_ATTACHMENT2
    enum: GL_COLOR_ATTACHMENT3
    enum: GL_COLOR_ATTACHMENT4
    enum: GL_COLOR_ATTACHMENT5
    enum: GL_COLOR_ATTACHMENT6
    enum: GL_COLOR_ATTACHMENT7
    enum: GL_COLOR_ATTACHMENT8
    enum: GL_COLOR_ATTACHMENT9
    enum: GL_COLOR_ATTACHMENT10
    enum: GL_COLOR_ATTACHMENT11
    enum: GL_COLOR_ATTACHMENT12
    enum: GL_COLOR_ATTACHMENT13
    enum: GL_COLOR_ATTACHMENT14
    enum: GL_COLOR_ATTACHMENT15
    enum: GL_DEPTH_ATTACHMENT
    enum: GL_STENCIL_ATTACHMENT
    enum: GL_FRAMEBUFFER
    enum: GL_RENDERBUFFER
    enum: GL_RENDERBUFFER_WIDTH
    enum: GL_RENDERBUFFER_HEIGHT
    enum: GL_RENDERBUFFER_INTERNAL_FORMAT
    enum: GL_STENCIL_INDEX1
    enum: GL_STENCIL_INDEX4
    enum: GL_STENCIL_INDEX8
    enum: GL_STENCIL_INDEX16
    enum: GL_RENDERBUFFER_RED_SIZE
    enum: GL_RENDERBUFFER_GREEN_SIZE
    enum: GL_RENDERBUFFER_BLUE_SIZE
    enum: GL_RENDERBUFFER_ALPHA_SIZE
    enum: GL_RENDERBUFFER_DEPTH_SIZE
    enum: GL_RENDERBUFFER_STENCIL_SIZE
    enum: GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE
    enum: GL_MAX_SAMPLES

    void glBindFramebuffer(GLenum target, GLuint framebuffer)
    void glDeleteFramebuffers(GLsizei n, const GLuint *framebuffers)
    void glGenFramebuffers(GLsizei n, GLuint *framebuffers)
    GLenum glCheckFramebufferStatus(GLenum target)
    void glFramebufferTexture1D(GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level)
    void glFramebufferTexture2D(GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level)
    void glFramebufferTexture3D(GLenum target, GLenum attachment, GLenum textarget, GLuint texture, GLint level, GLint zoffset)
    void glFramebufferRenderbuffer(GLenum target, GLenum attachment, GLenum renderbuffertarget, GLuint renderbuffer)



    #blend fns
    void glBlendFuncSeparate 'glBlendFuncSeparateEXT' (GLenum sfactorRGB, GLenum dfactorRGB, GLenum sfactorAlpha, GLenum dfactorAlpha)


    #shaders:
    ctypedef char GLchar
    ctypedef void *GLhandle

    enum: GL_VERTEX_SHADER
    enum: GL_MAX_VERTEX_UNIFORM_COMPONENTS
    enum: GL_MAX_TEXTURE_COORDS
    enum: GL_MAX_TEXTURE_IMAGE_UNITS
    enum: GL_MAX_VARYING_FLOATS
    enum: GL_MAX_VERTEX_ATTRIBS
    enum: GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS
    enum: GL_VERTEX_PROGRAM_POINT_SIZE
    enum: GL_VERTEX_PROGRAM_TWO_SIDE
    enum: GL_OBJECT_ACTIVE_ATTRIBUTES
    enum: GL_OBJECT_ACTIVE_ATTRIBUTE_MAX_LENGTH
    enum: GL_VERTEX_ATTRIB_ARRAY_ENABLED
    enum: GL_VERTEX_ATTRIB_ARRAY_SIZE
    enum: GL_VERTEX_ATTRIB_ARRAY_STRIDE
    enum: GL_VERTEX_ATTRIB_ARRAY_TYPE
    enum: GL_VERTEX_ATTRIB_ARRAY_NORMALIZED
    enum: GL_CURRENT_VERTEX_ATTRIB
    enum: GL_VERTEX_ATTRIB_ARRAY_POINTER


    enum: GL_BLEND_EQUATION_RGB
    enum: GL_VERTEX_ATTRIB_ARRAY_ENABLED
    enum: GL_VERTEX_ATTRIB_ARRAY_SIZE
    enum: GL_VERTEX_ATTRIB_ARRAY_STRIDE
    enum: GL_VERTEX_ATTRIB_ARRAY_TYPE
    enum: GL_CURRENT_VERTEX_ATTRIB
    enum: GL_VERTEX_PROGRAM_POINT_SIZE
    enum: GL_VERTEX_ATTRIB_ARRAY_POINTER
    enum: GL_STENCIL_BACK_FUNC
    enum: GL_STENCIL_BACK_FAIL
    enum: GL_STENCIL_BACK_PASS_DEPTH_FAIL
    enum: GL_STENCIL_BACK_PASS_DEPTH_PASS
    enum: GL_MAX_DRAW_BUFFERS
    enum: GL_DRAW_BUFFER0
    enum: GL_DRAW_BUFFER1
    enum: GL_DRAW_BUFFER2
    enum: GL_DRAW_BUFFER3
    enum: GL_DRAW_BUFFER4
    enum: GL_DRAW_BUFFER5
    enum: GL_DRAW_BUFFER6
    enum: GL_DRAW_BUFFER7
    enum: GL_DRAW_BUFFER8
    enum: GL_DRAW_BUFFER9
    enum: GL_DRAW_BUFFER10
    enum: GL_DRAW_BUFFER11
    enum: GL_DRAW_BUFFER12
    enum: GL_DRAW_BUFFER13
    enum: GL_DRAW_BUFFER14
    enum: GL_DRAW_BUFFER15
    enum: GL_BLEND_EQUATION_ALPHA
    enum: GL_MAX_VERTEX_ATTRIBS
    enum: GL_VERTEX_ATTRIB_ARRAY_NORMALIZED
    enum: GL_MAX_TEXTURE_IMAGE_UNITS
    enum: GL_FRAGMENT_SHADER
    enum: GL_VERTEX_SHADER
    enum: GL_MAX_FRAGMENT_UNIFORM_COMPONENTS
    enum: GL_MAX_VERTEX_UNIFORM_COMPONENTS
    enum: GL_MAX_VARYING_FLOATS
    enum: GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS
    enum: GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS
    enum: GL_SHADER_TYPE
    enum: GL_FLOAT_VEC2
    enum: GL_FLOAT_VEC3
    enum: GL_FLOAT_VEC4
    enum: GL_INT_VEC2
    enum: GL_INT_VEC3
    enum: GL_INT_VEC4
    enum: GL_BOOL
    enum: GL_BOOL_VEC2
    enum: GL_BOOL_VEC3
    enum: GL_BOOL_VEC4
    enum: GL_FLOAT_MAT2
    enum: GL_FLOAT_MAT3
    enum: GL_FLOAT_MAT4
    enum: GL_SAMPLER_1D
    enum: GL_SAMPLER_2D
    enum: GL_SAMPLER_3D
    enum: GL_SAMPLER_CUBE
    enum: GL_SAMPLER_1D_SHADOW
    enum: GL_SAMPLER_2D_SHADOW
    enum: GL_DELETE_STATUS
    enum: GL_COMPILE_STATUS
    enum: GL_LINK_STATUS
    enum: GL_VALIDATE_STATUS
    enum: GL_INFO_LOG_LENGTH
    enum: GL_ATTACHED_SHADERS
    enum: GL_ACTIVE_UNIFORMS
    enum: GL_ACTIVE_UNIFORM_MAX_LENGTH
    enum: GL_SHADER_SOURCE_LENGTH
    enum: GL_ACTIVE_ATTRIBUTES
    enum: GL_ACTIVE_ATTRIBUTE_MAX_LENGTH
    enum: GL_FRAGMENT_SHADER_DERIVATIVE_HINT
    enum: GL_SHADING_LANGUAGE_VERSION
    enum: GL_CURRENT_PROGRAM
    enum: GL_POINT_SPRITE_COORD_ORIGIN
    enum: GL_LOWER_LEFT
    enum: GL_UPPER_LEFT
    enum: GL_STENCIL_BACK_REF
    enum: GL_STENCIL_BACK_VALUE_MASK
    enum: GL_STENCIL_BACK_WRITEMASK

    void glBlendEquationSeparate (GLenum modeRGB, GLenum modeAlpha)
    void glDrawBuffers (GLsizei n, const GLenum *bufs)
    void glStencilOpSeparate (GLenum face, GLenum sfail, GLenum dpfail, GLenum dppass)
    void glStencilFuncSeparate (GLenum face, GLenum func, GLint ref, GLuint mask)
    void glStencilMaskSeparate (GLenum face, GLuint mask)
    void glAttachShader (GLuint program, GLuint shader)
    void glBindAttribLocation (GLuint program, GLuint index, const GLchar *name)
    void glCompileShader (GLuint shader)
    GLuint glCreateProgram ()
    GLuint glCreateShader (GLenum type)
    void glDeleteProgram (GLuint program)
    void glDeleteShader (GLuint shader)
    void glDetachShader (GLuint program, GLuint shader)
    void glDisableVertexAttribArray (GLuint index)
    void glEnableVertexAttribArray (GLuint index)
    void glGetActiveAttrib (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name)
    void glGetActiveUniform (GLuint program, GLuint index, GLsizei bufSize, GLsizei *length, GLint *size, GLenum *type, GLchar *name)
    void glGetAttachedShaders (GLuint program, GLsizei maxCount, GLsizei *count, GLuint *shaders)
    GLint glGetAttribLocation (GLuint program, const GLchar *name)
    void glGetProgramiv (GLuint program, GLenum pname, GLint *params)
    void glGetProgramInfoLog (GLuint program, GLsizei bufSize, GLsizei *length, GLchar *infoLog)
    void glGetShaderiv (GLuint shader, GLenum pname, GLint *params)
    void glGetShaderInfoLog (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *infoLog)
    void glGetShaderSource (GLuint shader, GLsizei bufSize, GLsizei *length, GLchar *source)
    GLint glGetUniformLocation (GLuint program, const GLchar *name)
    void glGetUniformfv (GLuint program, GLint location, GLfloat *params)
    void glGetUniformiv (GLuint program, GLint location, GLint *params)
    void glGetVertexAttribdv (GLuint index, GLenum pname, GLdouble *params)
    void glGetVertexAttribfv (GLuint index, GLenum pname, GLfloat *params)
    void glGetVertexAttribiv (GLuint index, GLenum pname, GLint *params)
    void glGetVertexAttribPointerv (GLuint index, GLenum pname, GLvoid* *pointer)
    GLboolean glIsProgram (GLuint program)
    GLboolean glIsShader (GLuint shader)
    void glLinkProgram (GLuint program)
    void glShaderSource (GLuint shader, GLsizei count, const GLchar* const *string, const GLint *length)
    void glUseProgram (GLuint program)
    void glUniform1f (GLint location, GLfloat v0)
    void glUniform2f (GLint location, GLfloat v0, GLfloat v1)
    void glUniform3f (GLint location, GLfloat v0, GLfloat v1, GLfloat v2)
    void glUniform4f (GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3)
    void glUniform1i (GLint location, GLint v0)
    void glUniform2i (GLint location, GLint v0, GLint v1)
    void glUniform3i (GLint location, GLint v0, GLint v1, GLint v2)
    void glUniform4i (GLint location, GLint v0, GLint v1, GLint v2, GLint v3)
    void glUniform1fv (GLint location, GLsizei count, const GLfloat *value)
    void glUniform2fv (GLint location, GLsizei count, const GLfloat *value)
    void glUniform3fv (GLint location, GLsizei count, const GLfloat *value)
    void glUniform4fv (GLint location, GLsizei count, const GLfloat *value)
    void glUniform1iv (GLint location, GLsizei count, const GLint *value)
    void glUniform2iv (GLint location, GLsizei count, const GLint *value)
    void glUniform3iv (GLint location, GLsizei count, const GLint *value)
    void glUniform4iv (GLint location, GLsizei count, const GLint *value)
    void glUniformMatrix2fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value)
    void glUniformMatrix3fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value)
    void glUniformMatrix4fv (GLint location, GLsizei count, GLboolean transpose, const GLfloat *value)
    void glValidateProgram (GLuint program)
    void glVertexAttrib1d (GLuint index, GLdouble x)
    void glVertexAttrib1dv (GLuint index, const GLdouble *v)
    void glVertexAttrib1f (GLuint index, GLfloat x)
    void glVertexAttrib1fv (GLuint index, const GLfloat *v)
    void glVertexAttrib1s (GLuint index, GLshort x)
    void glVertexAttrib1sv (GLuint index, const GLshort *v)
    void glVertexAttrib2d (GLuint index, GLdouble x, GLdouble y)
    void glVertexAttrib2dv (GLuint index, const GLdouble *v)
    void glVertexAttrib2f (GLuint index, GLfloat x, GLfloat y)
    void glVertexAttrib2fv (GLuint index, const GLfloat *v)
    void glVertexAttrib2s (GLuint index, GLshort x, GLshort y)
    void glVertexAttrib2sv (GLuint index, const GLshort *v)
    void glVertexAttrib3d (GLuint index, GLdouble x, GLdouble y, GLdouble z)
    void glVertexAttrib3dv (GLuint index, const GLdouble *v)
    void glVertexAttrib3f (GLuint index, GLfloat x, GLfloat y, GLfloat z)
    void glVertexAttrib3fv (GLuint index, const GLfloat *v)
    void glVertexAttrib3s (GLuint index, GLshort x, GLshort y, GLshort z)
    void glVertexAttrib3sv (GLuint index, const GLshort *v)
    void glVertexAttrib4Nbv (GLuint index, const GLbyte *v)
    void glVertexAttrib4Niv (GLuint index, const GLint *v)
    void glVertexAttrib4Nsv (GLuint index, const GLshort *v)
    void glVertexAttrib4Nub (GLuint index, GLubyte x, GLubyte y, GLubyte z, GLubyte w)
    void glVertexAttrib4Nubv (GLuint index, const GLubyte *v)
    void glVertexAttrib4Nuiv (GLuint index, const GLuint *v)
    void glVertexAttrib4Nusv (GLuint index, const GLushort *v)
    void glVertexAttrib4bv (GLuint index, const GLbyte *v)
    void glVertexAttrib4d (GLuint index, GLdouble x, GLdouble y, GLdouble z, GLdouble w)
    void glVertexAttrib4dv (GLuint index, const GLdouble *v)
    void glVertexAttrib4f (GLuint index, GLfloat x, GLfloat y, GLfloat z, GLfloat w)
    void glVertexAttrib4fv (GLuint index, const GLfloat *v)
    void glVertexAttrib4iv (GLuint index, const GLint *v)
    void glVertexAttrib4s (GLuint index, GLshort x, GLshort y, GLshort z, GLshort w)
    void glVertexAttrib4sv (GLuint index, const GLshort *v)
    void glVertexAttrib4ubv (GLuint index, const GLubyte *v)
    void glVertexAttrib4uiv (GLuint index, const GLuint *v)
    void glVertexAttrib4usv (GLuint index, const GLushort *v)
    void glVertexAttribPointer (GLuint index, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const GLvoid *pointer)



