# Makefile for Gambit-C interpreter on windows

all: gsi.exe

!include ..\misc\winconf.mak

.SUFFIXES:
.SUFFIXES: .scm .c .obj

CSRCS_LIB=	_gsilib.c
CSRCS_APP=	_gsi.c

OBJS_LIB= $(CSRCS_LIB:.c=.obj) _gambcgsi.obj
OBJS_APP= $(CSRCS_APP:.c=.obj) _gsi_.obj

VOLATILE_C= $(CSRCS_LIB) $(CSRCS_APP) _gambcgsi.c _gsi_.c

COMP_GEN=$(CCUNICODE) $(CCDBG) /nologo /GS /RTC1 /MT /D_CRT_SECURE_NO_DEPRECATE /c /I..\include

_gambcgsi.c: $(CSRCS_LIB) ..\lib\_gambc.c
	..\gsc-comp -f -link -l ..\lib\_gambc -o $@ $(CSRCS_LIB)

_gsi_.c: $(CSRCS_APP) _gambcgsi.c
	..\gsc-comp -f -link -l _gambcgsi -o $@ $(CSRCS_APP)

.scm.c:
	..\gsc-comp -f -c -check $*.scm

HEADERS_SCM= ..\lib\header.scm ..\lib\gambit^#.scm ..\lib\_gambit^#.scm

_gsi.c: _gsi.scm main.scm $(HEADERS_SCM)

_gsilib.c: _gsilib.scm $(HEADERS_SCM)

_gsi.obj: _gsi.c ..\include\gambit.h
	cl $(COMP_GEN) /D___SINGLE_HOST _gsi.c

_gsi_.obj: _gsi_.c ..\include\gambit.h
	cl $(COMP_GEN) /D___SINGLE_HOST _gsi_.c

.c.obj: 
	cl $(COMP_GEN) /D___SINGLE_HOST /D___LIBRARY  $*.c

_gambcgsi.obj: _gambcgsi.c ..\include\gambit.h

_gsilib.obj: _gsilib.c ..\include\gambit.h

gsi.exe: $(OBJS_LIB) $(OBJS_APP) ..\lib\libgambc.lib
	 cl $(CCDBG) -Fegsi.exe ..\lib\libgambc.lib $(OBJS_LIB) $(OBJS_APP) Kernel32.Lib User32.Lib Gdi32.Lib WS2_32.Lib


clean:
	-del $(OBJS_LIB) $(OBJS_APP) gsi.exe

realclean: clean
	-del $(VOLATILE_C)

bootclean: realclean
