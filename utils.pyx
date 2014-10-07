cimport cgl as gl


cpdef hello(int maxx):
    gl.glLineWidth(1)
    gl.glColor4f(0.,0.,0.,.5)
    gl.glBegin(gl.GL_LINES)
    cdef int x
    for x in range(maxx):
        gl.glVertex3f(x*3,500,0.0)
        gl.glVertex3f(0,0,0.0)
    gl.glEnd()



