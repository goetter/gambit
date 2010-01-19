# Configuration file for Windows build

CCDBG=-Oityb1
# CCDBG=-Zi -Od -Wp64

CCUNICODE=/DUNICODE /D_UNICODE /DUSE_wchar

CCSYSTYPE=/D___SYS_TYPE_CPU=\"i686\" /D___SYS_TYPE_VENDOR=\"pc\" /D___SYS_TYPE_OS=\"visualc\"
# CCSYSTYPE=/D___SYS_TYPE_CPU=\"amd64\" /D___SYS_TYPE_VENDOR=\"pc\" /D___SYS_TYPE_OS=\"visualc\"

GHPTRWIDTH=___LONG_WIDTH
# GHPTRWIDTH=___LONGLONG_WIDTH
