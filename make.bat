REM make.bat
REM Makefile for W32.Evol obfuscation engine for Windows
REM 
REM Assember: MAMS32 (ml.exe)
REM Linker: MASM32 (link.exe)
REM Ensure that MASM32 bin directory is in your PATH
REM 
REM NOT TESTED 

@echo off
ml /nologo /c /coff src\w32evol.asm
link /SUBSYSTEM:CONSOLE w32evol.obj
