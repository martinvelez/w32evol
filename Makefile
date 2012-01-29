#
# Makefile for W32.Evol obfuscation engine
#
# Assembler: MAMS32 (ml.exe) 
# Linker: MASM32 (link.exe)
#

SHELL			= /bin/sh
INSTALL		= /
AS				= wine "C:\\masm32\\bin\\ml.exe"
ASFLAGS 	= /nologo /c /coff
LD				= wine "C:\\masm32\\bin\\link.exe"
LDFLAGS		= /nologo /SUBSYSTEM:CONSOLE


DESTDIR		= .
srcdir		= src
bindir 		= $(DESTDIR)/bin


install: all
	mkdir $(bindir)
	mv w32evol.exe $(bindir)

all: w32evol.exe

w32evol.obj : $(srcdir)/w32evol.asm $(srcdir)/engine.asm $(srcdir)/helper_functions.asm
	$(AS) $(ASFLAGS) $(SRCDIR)/w32evol.asm

w32evol.exe : w32evol.obj
	$(LD) $(LDFLAGS) w32evol.obj

clean : 
	rm -f w32evol.obj w32evol.exe *~
