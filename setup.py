import os, platform
from stat import ST_MTIME


from distutils.core import setup
from distutils.extension import Extension

from Cython.Build import cythonize

from glew_pxd import generate_pxd

if platform.system() == 'Darwin':
	glew_header = '/usr/local/Cellar/glew/1.10.0/include/GL/glew.h'
	includes = []
	link_args = []
	libs = ['GLEW']
elif platform.system() == 'Windows':
	generate_pxd('path_to_glew.h')
	includes = []
	libs = ['GLEW32']
	link_args = []
else:
	glew_header = '/usr/include/GL/glew.h'
	includes = []
	libs = ['GLEW']
	link_args = []



extensions = [
	#first submodule: utils
	Extension(	name="cygl.utils",
				sources=['utils.pyx'],
				include_dirs = includes,
				libraries = libs,
				extra_link_args=link_args,
				extra_compile_args=[]),
	Extension(	name="cygl.shader",
				sources=['shader.pyx'],
				include_dirs = includes,
				libraries = libs,
				extra_link_args=link_args,
				extra_compile_args=[]),
]

if os.path.isfile('glew.pxd') and os.stat('glew.pxd')[ST_MTIME] > os.stat(glew_header)[ST_MTIME]:
    print "'glew.pxd' is up-to-date."
else:
    generate_pxd(glew_header,'pyglui/cygl')



setup( 	name="cygl",
		version="0.0.1",
		author= 'Moritz Kassner',
		licence = 'MIT',
		# dependencies are in flat dir for submodule integration
		# this way the source and compiled extension will have the same file layout.
		# disutils should treat the files in this dir as being in a dir called cygl.
		package_dir= {'cygl':''},
		#this package shall be called cygl
		packages = ['cygl'],
		description="OpenGL utility functions powered by python. This module can also be used as a submodule for other cython projects that want to use OpenGL.",
		ext_modules=cythonize(extensions)
)