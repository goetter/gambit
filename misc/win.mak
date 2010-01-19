# CWD must be the Gambit main directory, not gambit/misc

all clean realclean bootclean:
	cd include
	$(MAKE) /f win.mak $(MAKEFLAGS) $@
	cd ..
	cd lib
	$(MAKE) /f win.mak $(MAKEFLAGS) $@
	cd ..
	cd gsi
	$(MAKE) /f win.mak $(MAKEFLAGS) $@
	cd ..
	cd gsc
	$(MAKE) /f win.mak $(MAKEFLAGS) $@
	cd ..

bootstrap: all
	-copy gsc-comp.exe gsc-comp.old
	copy gsc\gsc.exe gsc-comp.exe