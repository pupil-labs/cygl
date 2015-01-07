from glew cimport *
cimport shader



cdef class RGBA:
    #cdef public float r,g,b,a
    def __cinit__(self,r=1,g=1,b=1,a=1):
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    def __init__(self,r=1,g=1,b=1,a=1):
        pass

    def __getitem__(self,idx):
        if isinstance(idx,slice):
            return (self.r,self.g,self.b,self.a)[idx]
        else:
            if idx==0:
                return self.r
            elif idx==1:
                return self.g
            elif idx==2:
                return self.b
            elif idx==3:
                return self.a

            raise IndexError()

    def __setitem__(self,idx,obj):
        if isinstance(idx,slice):
            t = [self.r,self.g,self.b,self.a]
            t[idx] = obj
            self.r,self.g,self.b,self.a = t
        else:
            raise IndexError()


cpdef init():
    return glewInit()

simple_pt_shader = None

cpdef draw_points(points,int size=20,RGBA color=RGBA(1.,0.5,0.5,.5),float sharpness=0.8):
    global simple_pt_shader # we cache the shader because we only create it the first time we call this fn.
    if not simple_pt_shader:

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

        GEOM_SHADER = """"""
        #shader link and compile
        simple_pt_shader = shader.Shader(VERT_SHADER,FRAG_SHADER,GEOM_SHADER)

    simple_pt_shader.bind()
    simple_pt_shader.uniform1f('size',size)
    simple_pt_shader.uniform1f('sharpness',sharpness)
    glColor4f(color.r,color.g,color.b,color.a)
    glBegin(GL_POINTS)
    for pt in points:
        glVertex3f(pt[0],pt[1],0)
    glEnd()
    simple_pt_shader.unbind()


