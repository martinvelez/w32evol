# w32evol -- x86 obfuscation engine
- - -

* Original Author: 	Unknown
* Author: 					[Martin Velez](http://www.martinvelez.com)
* Copyright: 				Copyright (C) 2011 [Martin Velez](http://www.martinvelez.com)
* License: 					[GPL](http://www.gnu.org/copyleft/gpl.html)

## Description 

**This repository does not contain a virus.**

This repository contains a command line interface to the obfuscation engine 
used by the W32.Evol virus.

The [Win32.Evol](http://www.symantec.com/security\_response/writeup.jsp?docid=2000-122010-0045-99)
virus appeared around July 2000 and was able to infect any major Win32
platform.  It used a metamorphic engine to rewrite its code during replication.
The purpose of its metamorphic engine was to create mutated copies of itself.
Hence, some of the transformations or rewritings it applies to instructions do
not necessarily obfuscate.  

We wrote evol.asm which drives the W32.Evol obfuscation engine and provides a 
command line interface.

## Dependencies

### General

* [MAMS32](http://www.masm32.com/)
    * ml.exe: assembler 
    * link.exe: linker

### Linux (Tested on Ubuntu 11.10)

* [wine](http://www.winehq.org/download/) (1.3 or greater, may work with 1.2)

See **APPENDIX A** for more information about installing MASM32 in Linux.

## Installation

The goal is to build w32evol.exe.  You can then place/install this executable 
wherever you please.  

Files to build w32evol.exe in Windows and Linux are included.

### Linux (Tested on Ubuntu 11.10)

	$ make

### Windows
 
	> make.bat

## Usage

	w32evol.exe <in.bin> <out.bin>

**in.bin**: input file; exists; contains raw binary code which represents x86 
instructions

**out.bin**: output file; create if does not exist; obfuscated raw binary code 
which represents x86 instructions

## Usage: Example 1

In this example, we use w32evol.exe to obfuscate (or transform) an instruction 
to an equivalent instruction in the Intel x86 instruction set. Unfortunately, 
the obfuscation engines add three extra bytes (00 00 00).  This demonstrates 
that some obfuscation engines have bugs.

	$ ndisasm in.bin
	00000000  83C00A            add ax,byte +0xa
	$ wine w32evol.exe in.bin out.bin
	$ ndisasm out.bin
	00000000  81C00A00          add ax,0xa
	00000004  0000              add [bx+si],al


## Development

### Source 
[Bitbucket](https://bitbucket.org/martinvelez/w32evol/src)

## Acknowledgements
* [Orr](http://www.antilife.org/files/Evol.pdf)
    * wrote an [article](www.openrce.org/articles/full\_view/27) in which described 
      how he disassembled the metamorphic engine used in the W32.Evol virus
    * He  was kind enough to email his disassembled code.  
* [VX Heavens](http://vx.netlux.org/vl.php?dir=Virus.Win32.Evol)
    * Disassembled source code obtained from orriscariot@gmail.com.  Some of his 
      functions contained errors which cause the program to fail.  We obtained 
      executabled code from http://vx.netlux.org/vl.php?dir=Virus.Win32.Evol, and 
      disassembled it using IDA Pro.  We found the mistakes in the disassembled 
      source code and corrected them.

## APPENDIX A: MASM32 and wine

It is possible to use MASM32 in Linux using wine.  When you download MAMS32, 
you get an installer file, install.exe.  Use wine to run that installer.  

	$ cd ~/Downloads
	$ ls
	install.exe
	$ wineconsole install.exe

I have installed MASM32 using wine in two different Ubuntu machines and the 
MASM32 libraries have not been built successfully.  I had to build the 
libraries myself.

	user@host:~/.wine/drive_c/masm32$ ls
	gtstbd.qsc  	dlgtmplt.qsc  licence       mnutoasm.exe   qetxt.bin     topgun.exe
	bin           examples      m32lib        multitool.exe  qsc.dll       tproc.exe
	bin2dbex.exe  fda32.exe     macros        plugins        script        tproc.txt
	blankdlg.qsc  fda.exe       makecimp.exe  procmap.exe    se.dll        tutorial
	bldmakit.qsc  fpulib        makecon.qsc   procs          shellex.exe   tview.exe
	blockp.ini    getcolor.exe  makelibs.bat  prostart.exe   subclass.exe  ueint.bin
	cg.exe        help          makerc.qsc    prostart.ini   testbed.qsc   uetxt.bin
	cg.ini        include       maketbl.exe   prostart.set   testinst      uniedit.exe
	cpicker.exe   intro.txt     mangle.exe    pths.ini       text          vkdebug
	datetime      jtmake.exe    masm32ci.exe  qeditor.exe    tmp.qsc       wcsch.exe
	dlgmake.exe   lib           menuedit.dll  qeint.bin      tools
	dlgproc.qsc   libbat.qsc    menus.ini     qetb.exe       topgun.chm
	user@host:~/.wine/drive_c/masm32$ makelibs.bat

