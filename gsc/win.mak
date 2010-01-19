# Makefile for Gambit-C compiler on windows

all: gsc.exe

!include ..\misc\winconf.mak

.SUFFIXES:
.SUFFIXES: .scm .c .obj

CSRCS_LIB=	_host.c _utils.c _source.c _parms.c _env.c _ptree1.c _ptree2.c _gvm.c _back.c _front.c _prims.c \
		_t-c-1.c _t-c-2.c _t-c-3.c _gsclib.c
CSRCS_APP=	_gsc.c

OBJS_LIB= $(CSRCS_LIB:.c=.obj) _gambcgsc.obj
OBJS_APP= $(CSRCS_APP:.c=.obj) _gsc_.obj

VOLATILE_C= $(CSRCS_LIB) $(CSRCS_APP) _gambcgsc.c _gsc_.c

COMP_GEN=$(CCUNICODE) $(CCDBG) /nologo /GS /RTC1 /MT /D_CRT_SECURE_NO_DEPRECATE /c /I..\include

_gambcgsc.c: $(CSRCS_LIB) ..\lib\_gambc.c
	..\gsc-comp -f -link -l ..\lib\_gambc -o $@ $(CSRCS_LIB)

_gsc_.c: $(CSRCS_APP) _gambcgsc.c
	..\gsc-comp -f -link -l _gambcgsc -o $@ $(CSRCS_APP)

.scm.c:
	..\gsc-comp -f -c -check $*.scm

HEADERS_SCM= ..\lib\header.scm ..\lib\gambit^#.scm ..\lib\_gambit^#.scm fixnum.scm generic.scm

_gsc.c: _gsc.scm ..\gsi\main.scm $(HEADERS_SCM)

_host.c: _host.scm $(HEADERS_SCM)
_utils.c: _utils.scm $(HEADERS_SCM)
_source.c: _source.scm $(HEADERS_SCM)
_parms.c: _parms.scm $(HEADERS_SCM)
_env.c: _env.scm $(HEADERS_SCM)
_ptree1.c: _ptree1.scm $(HEADERS_SCM)
_ptree2.c: _ptree2.scm $(HEADERS_SCM)
_gvm.c: _gvm.scm $(HEADERS_SCM)
_back.c: _back.scm $(HEADERS_SCM)
_front.c: _front.scm $(HEADERS_SCM)
_prims.c: _prims.scm $(HEADERS_SCM)
_t-c-1.c: _t-c-1.scm $(HEADERS_SCM)
_t-c-2.c: _t-c-2.scm $(HEADERS_SCM)
_t-c-3.c: _t-c-3.scm $(HEADERS_SCM)
_gsclib.c: _gsclib.scm $(HEADERS_SCM)

_gsc.obj: _gsc.c ..\include\gambit.h
	cl $(COMP_GEN) /D___SINGLE_HOST _gsc.c

_gsc_.obj: _gsc_.c ..\include\gambit.h
	cl $(COMP_GEN) /D___SINGLE_HOST _gsc_.c

.c.obj: 
	cl $(COMP_GEN) /D___SINGLE_HOST /D___LIBRARY  $*.c

_gambcgsc.obj: _gambcgsc.c ..\include\gambit.h

_host.obj: _host.c ..\include\gambit.h
_utils.obj: _utils.c ..\include\gambit.h
_source.obj: _source.c ..\include\gambit.h
_parms.obj: _parms.c ..\include\gambit.h
_env.obj: _env.c ..\include\gambit.h
_ptree1.obj: _ptree1.c ..\include\gambit.h
_ptree2.obj: _ptree2.c ..\include\gambit.h
_gvm.obj: _gvm.c ..\include\gambit.h
_back.obj: _back.c ..\include\gambit.h
_front.obj: _front.c ..\include\gambit.h
_prims.obj: _prims.c ..\include\gambit.h
_t-c-1.obj: _t-c-1.c ..\include\gambit.h
_t-c-2.obj: _t-c-2.c ..\include\gambit.h
_t-c-3.obj: _t-c-3.c ..\include\gambit.h
_gsclib.obj: _gsclib.c ..\include\gambit.h


gsc.exe: $(OBJS_LIB) $(OBJS_APP) ..\lib\libgambc.lib
	 cl $(CCDBG) -Fegsc.exe ..\lib\libgambc.lib $(OBJS_LIB) $(OBJS_APP) Kernel32.Lib User32.Lib Gdi32.Lib WS2_32.Lib


clean:
	-del $(OBJS_LIB) $(OBJS_APP) gsc.exe

realclean: clean
	-del $(VOLATILE_C)

bootclean: realclean