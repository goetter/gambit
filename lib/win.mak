# Makefile for Gambit-C library on Windows

all: libgambc.lib

!include ..\misc\winconf.mak

CSRCS_PR_MH=	_num.c _io.c
CSRCS_PR_SH=	main.c setup.c mem.c \
		os.c os_base.c os_time.c os_shell.c os_files.c os_dyn.c os_tty.c os_io.c \
		c_intf.c \
		_kernel.c _system.c _std.c _eval.c _nonstd.c _thread.c _repl.c \
		_gambc.c

OBJS_PR_MH= $(CSRCS_PR_MH:.c=.obj)
OBJS_PR_SH= $(CSRCS_PR_SH:.c=.obj)

COMP_GEN=$(CCUNICODE) $(CCDBG) /nologo /GS /RTC1 /MT /D_CRT_SECURE_NO_DEPRECATE /c /I..\include $(CCSYSTYPE)


_io.obj: _io.c ..\include\gambit.h
	 cl $(COMP_GEN) /D___LIBRARY /D___PRIMAL _io.c

_num.obj: _num.c mem.h ..\include\gambit.h
	 cl $(COMP_GEN) /D___LIBRARY /D___PRIMAL _num.c


.c.obj: 
	cl $(COMP_GEN) /D___LIBRARY /D___SINGLE_HOST /D___PRIMAL $*.c

main.obj: main.c ..\include\gambit.h os_base.h os_shell.h setup.h
setup.obj: setup.c ..\include\gambit.h os_base.h os_dyn.h setup.h mem.h c_intf.h
mem.obj: mem.c mem.h ..\include\gambit.h os_base.h os_time.h setup.h c_intf.h
os.obj: os.c ..\include\gambit.h os_base.h os_time.h os_shell.h os_files.h os_dyn.h os_tty.h os_io.h setup.h mem.h c_intf.h
os_base.obj: os_base.c ..\include\gambit.h os_base.h setup.h
os_time.obj: os_time.c ..\include\gambit.h os_base.h os_time.h
os_shell.obj: os_shell.c ..\include\gambit.h os_base.h os_shell.h os_files.h
os_files.obj: os_files.c ..\include\gambit.h os_base.h os_shell.h os_files.h setup.h
os_dyn.obj: os_dyn.c ..\include\gambit.h os_base.h os_shell.h os_dyn.h
os_tty.obj: os_tty.c ..\include\gambit.h os_base.h os_shell.h os_tty.h os_io.h setup.h c_intf.h
os_io.obj: os_io.c ..\include\gambit.h os_base.h os_files.h os_tty.h os_io.h setup.h c_intf.h
c_intf.obj: c_intf.c ..\include\gambit.h os_base.h os_dyn.h setup.h mem.h c_intf.h
_kernel.obj: _kernel.c ..\include\gambit.h os.h os_base.h os_time.h os_shell.h os_files.h os_dyn.h os_tty.h os_io.h setup.h mem.h c_intf.h ..\include\stamp.h
_system.obj: _system.c ..\include\gambit.h
_std.obj: _std.c ..\include\gambit.h os.h
_eval.obj: _eval.c ..\include\gambit.h
_nonstd.obj: _nonstd.c ..\include\gambit.h
_thread.obj: _thread.c ..\include\gambit.h
_repl.obj: _repl.c ..\include\gambit.h
gambc.obj: _gambc.c ..\include\gambit.h


libgambc.lib: $(OBJS_PR_MH) $(OBJS_PR_SH)
	      lib /out:libgambc.lib $(OBJS_PR_MH) $(OBJS_PR_SH)
