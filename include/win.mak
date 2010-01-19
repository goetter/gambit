
all: gambit.h

!include ..\misc\winconf.mak

gambit.h: gambit.h.in
	  echo #ifndef ___VOIDSTAR_WIDTH                > gambit.h
	  echo #define ___VOIDSTAR_WIDTH $(GHPTRWIDTH) >> gambit.h
	  echo #endif    	                       >> gambit.h
	  echo #ifndef ___MAX_CHR                      >> gambit.h
	  echo #define ___MAX_CHR 0x10ffff             >> gambit.h
	  echo #endif                                  >> gambit.h
	  type gambit.h.in                             >> gambit.h

