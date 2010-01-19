all: _inc _lib _gsi _gsc

_inc:
	cd include
	$(MAKE) /f win.mak
	cd ..

_lib:
	cd lib
	$(MAKE) /f win.mak
	cd ..

_gsi:
	cd gsi
	$(MAKE) /f win.mak
	cd ..

_gsc:
	cd gsc
	$(MAKE) /f win.mak
	cd ..
