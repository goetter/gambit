setlocal
call "C:\Program Files\Microsoft Visual Studio 9.0\VC\bin\vcvars32.bat"

REM For Win64 build, use following instead, and tweak misc\winconf.mak
REM call "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\vcvarsall.bat" amd64

REM Don't forget to "make clean" when changing platforms

nmake /f misc\win.mak %1 %2 %3 %4 %5 %6