#
# Makefile for W32.Evol obfuscation engine
#
# Assembler: MAMS32 (ml.exe) 
# Linker: MASM32 (link.exe)
#


AS				= wine "C:\\masm32\\bin\\ml.exe"
ASFLAGS 	= /nologo /c /coff

LD				= wine "C:\\masm32\\bin\\link.exe"
LDFLAGS		= /SUBSYSTEM:CONSOLE

w32evol.obj : w32evol.asm engine.asm helper_functions.asm
	$(AS) $(ASFLAGS) w32evol.asm

w32evol.exe : w32evol.obj
	$(LD) $(LDFLAGS) w32evol.obj
