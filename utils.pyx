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
    global simple_pt_shader
    simple_pt_shader = None
    return glewInit()

simple_pt_shader = None

cpdef draw_points(points,float size=20,RGBA color=RGBA(1.,0.5,0.5,.5),float sharpness=0.8):
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

cpdef draw_points_norm(points,float size=20,RGBA color=RGBA(1.,0.5,0.5,.5),float sharpness=0.8):

    glMatrixMode(GL_PROJECTION)
    glPushMatrix()
    glLoadIdentity()
    glOrtho(0, 1, 0, 1, -1, 1) # gl coord convention
    glMatrixMode(GL_MODELVIEW)
    glPushMatrix()
    glLoadIdentity()

    draw_points(points,size,color,sharpness)

    glMatrixMode(GL_PROJECTION)
    glPopMatrix()
    glMatrixMode(GL_MODELVIEW)
    glPopMatrix()

cpdef draw_polyline(verts,float thickness=1,RGBA color=RGBA(1.,0.5,0.5,.5),line_type = GL_LINE_STRIP):
    glColor4f(color.r,color.g,color.b,color.a)
    glLineWidth(thickness)
    glBegin(line_type)
    for v in verts:
        glVertex3f(v[0],v[1],0)
    glEnd()

cpdef draw_polyline_norm(verts,float thickness=1,RGBA color=RGBA(1.,0.5,0.5,.5),line_type = GL_LINE_STRIP):
    glMatrixMode(GL_PROJECTION)
    glPushMatrix()
    glLoadIdentity()
    glOrtho(0, 1, 0, 1, -1, 1) # gl coord convention
    glMatrixMode(GL_MODELVIEW)
    glPushMatrix()
    glLoadIdentity()

    draw_polyline(verts,thickness,color,line_type)

    glMatrixMode(GL_PROJECTION)
    glPopMatrix()
    glMatrixMode(GL_MODELVIEW)
    glPopMatrix()


def create_named_texture(shape):
    if len(shape) ==2:
        height, width = shape
        channels = 1
    elif len(shape) ==3:
        height, width, channels = shape
    else:
        raise Exception()

    gl_blend = (None,GL_LUMINANCE,None,GL_BGR,GL_BGRA)[channels]
    gl_blend_init = (None,GL_LUMINANCE,None,GL_RGB,GL_RGBA)[channels]

    glPixelStorei(GL_UNPACK_ALIGNMENT,1)
    cdef GLuint texture_id = 0
    glGenTextures(1, &texture_id)
    glBindTexture(GL_TEXTURE_2D, texture_id)
    # Create Texture
    glTexImage2D(GL_TEXTURE_2D,
                        0,
                        gl_blend_init,
                        width,
                        height,
                        0,
                        gl_blend,
                        GL_UNSIGNED_BYTE,
                        NULL)

    return texture_id

def destroy_named_texture(int texture_id):
    cdef GLuint texture_cid = texture_id
    glDeleteTextures(1,&texture_cid)

def update_named_texture(texture_id, image):
    cdef unsigned char[:,:,:] data_3
    cdef unsigned char[:,:] data_1

    glBindTexture(GL_TEXTURE_2D, texture_id)

    if len(image.shape) == 2:
        height, width = image.shape
        channels = 1
        data_1 = image

    else:
        height, width, channels = image.shape
        data_3 = image

    gl_blend = (None,GL_LUMINANCE,None,GL_BGR,GL_BGRA)[channels]
    gl_blend_init = (None,GL_LUMINANCE,None,GL_RGB,GL_RGBA)[channels]

    glPixelStorei(GL_UNPACK_ALIGNMENT,1)
    # Create Texture and upload data
    if channels ==1:
        glTexImage2D(GL_TEXTURE_2D,
                        0,
                        gl_blend_init,
                        width,
                        height,
                        0,
                        gl_blend,
                        GL_UNSIGNED_BYTE,
                        <void*>&data_1[0,0])
    else:
        glTexImage2D(GL_TEXTURE_2D,
                        0,
                        gl_blend_init,
                        width,
                        height,
                        0,
                        gl_blend,
                        GL_UNSIGNED_BYTE,
                        <void*>&data_3[0,0,0])

    glBindTexture(GL_TEXTURE_2D, 0)


def draw_named_texture(texture_id, interpolation=True, quad=((0.,0.),(1.,0.),(1.,1.),(0.,1.))):
    """
    We draw the image as a texture on a quad from 0,0 to img.width,img.height.
    We set the coord system to pixel dimensions.
    to save cpu power, update can be false and we will reuse the old img instead of uploading the new.
    """

    glBindTexture(GL_TEXTURE_2D, texture_id)
    glEnable(GL_TEXTURE_2D)

    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST) # interpolation here
    if not interpolation:
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

    # someday replace with this:
    # glEnableClientState(GL_VERTEX_ARRAY)
    # glEnableClientState(GL_TEXTURE_COORD_ARRAY)
    # Varray = numpy.array([[0,0],[0,1],[1,1],[1,0]],numpy.float)
    # glVertexPointer(2,GL_FLOAT,0,Varray)
    # glTexCoordPointer(2,GL_FLOAT,0,Varray)
    # indices = [0,1,2,3]
    # glDrawElements(GL_QUADS,1,GL_UNSIGNED_SHORT,indices)
    glColor4f(1.0,1.0,1.0,1.0)
    # Draw textured Quad.
    glBegin(GL_QUADS)
    # glTexCoord2f(0.0, 0.0)
    glTexCoord2f(0.0, 1.0)
    glVertex2f(quad[0][0],quad[0][1])
    glTexCoord2f(1.0, 1.0)
    glVertex2f(quad[1][0],quad[1][1])
    glTexCoord2f(1.0, 0.0)
    glVertex2f(quad[2][0],quad[2][1])
    glTexCoord2f(0.0, 0.0)
    glVertex2f(quad[3][0],quad[3][1])
    glEnd()

    glBindTexture(GL_TEXTURE_2D, 0)
    glDisable(GL_TEXTURE_2D)



def draw_gl_texture(image,interpolation=True):
    """
    We draw the image as a texture on a quad from 0,0 to img.width,img.height.
    Simple anaymos texture one time use. Look at named texture fn's for better perfomance
    """
    cdef unsigned char[:,:,:] data_3
    cdef unsigned char[:,:] data_1
    if len(image.shape) == 2:
        height, width = image.shape
        channels = 1
        data_1 = image

    else:
        height, width, channels = image.shape
        data_3 = image
    gl_blend = (None,GL_LUMINANCE,None,GL_BGR,GL_BGRA)[channels]
    gl_blend_init = (None,GL_LUMINANCE,None,GL_RGB,GL_RGBA)[channels]

    glPixelStorei(GL_UNPACK_ALIGNMENT,1)
    glEnable(GL_TEXTURE_2D)
    # Create Texture and upload data
    if channels ==1:
        glTexImage2D(GL_TEXTURE_2D,
                        0,
                        gl_blend_init,
                        width,
                        height,
                        0,
                        gl_blend,
                        GL_UNSIGNED_BYTE,
                        <void*>&data_1[0,0])
    else:
        glTexImage2D(GL_TEXTURE_2D,
                        0,
                        gl_blend_init,
                        width,
                        height,
                        0,
                        gl_blend,
                        GL_UNSIGNED_BYTE,
                        <void*>&data_3[0,0,0])

    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST) # interpolation here
    if not interpolation:
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);


    glColor4f(1.0,1.0,1.0,1.0)
    # Draw textured Quad.
    glBegin(GL_QUADS)
    glTexCoord2f(0.0, 1.0)
    glVertex2f(0,0)
    glTexCoord2f(1.0, 1.0)
    glVertex2f(1,0)
    glTexCoord2f(1.0, 0.0)
    glVertex2f(1,1)
    glTexCoord2f(0.0, 0.0)
    glVertex2f(0,1)
    glEnd()

    glDisable(GL_TEXTURE_2D)


