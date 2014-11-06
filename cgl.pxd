IF UNAME_SYSNAME == "Windows":
    include 'gl1_win.pxi'
    include 'glext_win.pxi'
ELIF UNAME_SYSNAME == "Darwin":
    include 'gl1.pxi'
    include 'gl3.pxi'
ELIF UNAME_SYSNAME == "Linux":
    include 'gl1.pxi'
    include 'glext.pxi'