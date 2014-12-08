from distutils.core import setup
from distutils.extension import Extension
import platform

from Cython.Build import cythonize


if platform.system() == 'Darwin':
	includes = []
	f = '-framework'
	link_args = [f, 'OpenGL']
	libs = []
	libglew = ["/usr/local/Cellar/glew/1.10.0/lib/libGLEW.a"]
elif platform.system() == 'Windows':
	includes = []
	libs = ['OpenGL32']
	link_args = []
	libglew = ["/usr/local/Cellar/glew/1.10.0/lib/libGLEW.a"]
else:
	includes = ['/usr/include/GL',]
	libs = ['GL']
	link_args = []
	libglew = ["/usr/lib/x86_64-linux-gnu/libGLEW/libGLEW.a"]


extensions = [
	#first submodule: utils
	Extension(	name="cygl.utils",
				sources=['utils.pyx'],
				include_dirs = includes,
				extra_objects = libglew,
				libraries = libs,
				extra_link_args=link_args,
				extra_compile_args=[]),
	Extension(	name="cygl.shader",
				sources=['shader.pyx'],
				include_dirs = includes,
				extra_objects = libglew,
				libraries = libs,
				extra_link_args=link_args,
				extra_compile_args=[]),
]

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