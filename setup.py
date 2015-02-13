import os, platform
from stat import ST_MTIME


from distutils.core import setup
from distutils.extension import Extension

from Cython.Build import cythonize

from glew_pxd import generate_pxd

if platform.system() == 'Darwin':
	glew_header = '/usr/local/Cellar/glew/1.10.0/include/GL/glew.h'
	includes = []
	lib_dir = []
	link_args = []
	libs = ['GLEW']
elif platform.system() == 'Windows':
	glew_header = 'win_glew/gl/glew.h'
	includes = ['win_glew']
	libs = ['glew32', 'openGL32']
	lib_dir = ['win_glew']
	link_args = []
else:
	glew_header = '/usr/include/GL/glew.h'
	includes = []
	libs = ['GLEW']
	lib_dir = []
	link_args = []

if os.path.isfile('glew.pxd') and os.stat('glew.pxd')[ST_MTIME] > os.stat(glew_header)[ST_MTIME]:
    print "'glew.pxd' is up-to-date."
else:
    print "generating glew.pxd based on '%s'"%glew_header
    generate_pxd(glew_header)


extensions = [
	#first submodule: utils
	Extension(	name="cygl.utils",
				sources=['utils.pyx'],
				include_dirs = includes,
				libraries = libs,
				library_dirs = lib_dir,
				extra_link_args=link_args,
				extra_compile_args=[]),
	Extension(	name="cygl.shader",
				sources=['shader.pyx'],
				include_dirs = includes,
				libraries = libs,
				library_dirs = lib_dir,
				extra_link_args=link_args,
				extra_compile_args=[]),
]


setup( 	name="cygl",
		version="0.0.1",
		author= 'Moritz Kassner',
		licence = 'MIT',
		#this package shall be called cygl
		packages = ['cygl'],
		# dependencies are in flat dir for submodule integration
		# this way the source and compiled extension will have the same file layout.
		# disutils should treat the files in this dir as being in a dir called cygl.
		package_dir= {'cygl':''},
        exclude_package_data= {'': ['glew_pxd.py'] },
		description="OpenGL utility functions powered by python. This module can also be used as a submodule for other cython projects that want to use OpenGL.",
		ext_modules=cythonize(extensions)
)
