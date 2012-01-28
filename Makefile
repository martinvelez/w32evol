#
# Makefile for W32.Evol obfuscation engine
#
# Assembler: MAMS32 (ml.exe) 
# Linker: MASM32 (link.exe)
#

all: w32evol.exe

AS				= wine "C:\\masm32\\bin\\ml.exe"
ASFLAGS 	= /nologo /c /coff

LD				= wine "C:\\masm32\\bin\\link.exe"
LDFLAGS		= /nologo /SUBSYSTEM:CONSOLE

SRC_DIR		= src

w32evol.obj : $(SRC_DIR)/w32evol.asm $(SRC_DIR)/engine.asm $(SRC_DIR)/helper_functions.asm
	$(AS) $(ASFLAGS) $(SRC_DIR)/w32evol.asm

w32evol.exe : w32evol.obj
	$(LD) $(LDFLAGS) w32evol.obj


clean : 
	rm -f w32evol.obj w32evol.exe
