# Makefile for Gambit-C interpreter on windows

all: gsi.exe

!include ..\misc\winconf.mak

CSRCS_LIB=	_gsilib.c _gambcgsi.c
CSRCS_APP=	_gsi.c _gsi_.c

OBJS_LIB= $(CSRCS_LIB:.c=.obj)
OBJS_APP= $(CSRCS_APP:.c=.obj)

COMP_GEN=$(CCUNICODE) $(CCDBG) /nologo /GS /RTC1 /MT /D_CRT_SECURE_NO_DEPRECATE /c /I..\include


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

