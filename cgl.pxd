IF UNAME_SYSNAME == "Windows":
    include 'cgl_win.pxd'
ELIF UNAME_SYSNAME == "Darwin":
    include 'cgl_default.pxd'
    include 'gl3.pxi'
ELIF UNAME_SYSNAME == "Linux":
    include 'cgl_default.pxd'
    include 'glext.pxi'