from cgl cimport *
cimport shader


cpdef hello(int maxx):
    glLineWidth(1)
    glColor4f(0.,0.,0.,.5)
    glBegin(GL_LINES)
    cdef int x
    for x in range(maxx):
        glVertex3f(x*3,500,0.0)
        glVertex3f(0,0,0.0)
    glEnd()



simple_pt_shader = None

cpdef draw_points(points,int size=20,object color=(1.,0.5,0.5,.5),float sharpness=0.8):
    global simple_pt_shader # we cache the shader because we only create it the first time we call this fn.
    if not simple_pt_shader:

        # we just draw single points, a VBO is much slower than this. But this is a little bit hacked.
        #someday we should replace all legacy fn with vbo's and shaders...
        # shader defines
        VERT_SHADER = """
        #version 120
        varying vec4 f_color;
        uniform float size = 20;
        uniform float sharpness = 0.8;

        void main () {
               gl_Position = gl_ModelViewProjectionMatrix*vec4(gl_Vertex.xyz,1.);
               gl_PointSize = size;
               f_color = gl_Color;
               }
        """

        FRAG_SHADER = """
        #version 120
        varying vec4 f_color;
        uniform float size = 20;
        uniform float sharpness = 0.8;
        void main()
        {
            float dist = distance(gl_PointCoord.xy, vec2(0.5, 0.5))*size;
            gl_FragColor = mix(f_color, vec4(f_color.rgb,0.0), smoothstep(sharpness*size*0.5, 0.5*size, dist));
        }
        """
        #shader link and compile
        simple_pt_shader = shader.Shader(VERT_SHADER,FRAG_SHADER)

    simple_pt_shader.bind()
    simple_pt_shader.uniform1f('size',size)
    simple_pt_shader.uniform1f('sharpness',sharpness)
    glColor4f(color[0],color[1],color[2],color[3])
    glBegin(GL_POINTS)
    for pt in points:
        glVertex3f(pt[0],pt[1],0)
    glEnd()
    simple_pt_shader.unbind()


from cython cimport view

cdef class Graph:
    cdef int[::1] data
    cdef int idx,d_len
    cdef int x,y

    def __cinit__(self,int data_points = 100):
        self.data = view.array(shape=(data_points,), itemsize=sizeof(int), format="i")

    def __init__(self,int data_points = 100):
        pass

    property pos:
        def __get__(self):
            return self.x,self.y

        def __set__(self,val):
            self.x,self.y = val







