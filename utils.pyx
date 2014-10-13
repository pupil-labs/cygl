cimport cgl as gl
cimport shader
cpdef hello(int maxx):
    gl.glLineWidth(1)
    gl.glColor4f(0.,0.,0.,.5)
    gl.glBegin(gl.GL_LINES)
    cdef int x
    for x in range(maxx):
        gl.glVertex3f(x*3,500,0.0)
        gl.glVertex3f(0,0,0.0)
    gl.glEnd()



simple_pt_shader = None

cdef draw_points(points,int size=20,object color=(1.,0.5,0.5,.5),float sharpness=0.8):
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
    gl.glColor4f(color[0],color[1],color[2],color[3])
    gl.glBegin(gl.GL_POINTS)
    for pt in points:
        gl.glVertex3f(pt[0],pt[1],0)
    gl.glEnd()
    simple_pt_shader.unbind()


