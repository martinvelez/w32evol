#w32evol -- an x86 obfuscation engine
- - -

## Table of Contents
1. Introduction
2. Dependencies
3. Installation
4. Usage
5. Development
6. APPENDIX A: MASM32 and wine

- - -

## 1. Introduction 
**Does not contain a virus**

w32evol is a command line interface to the obfuscation/metamorphic engine used
by the
[Win32.Evol](http://www.symantec.com/security\_response/writeup.jsp?docid=2000-122010-0045-99)
virus. It rewrites files containing x86 instructions encoded in binary.  

The
[Win32.Evol](http://www.symantec.com/security\_response/writeup.jsp?docid=2000-122010-0045-99)
virus appeared around July 2000 and was able to infect any major Win32
platform.  It used this metamorphic engine to rewrite its code during
replication. The purpose of its metamorphic engine was to create mutated copies
of itself.Hence, some of the transformations or rewritings it applies to
instructions do not necessarily obfuscate.  

## 2. Dependencies

### General

* [MAMS32](http://www.masm32.com/)
    * ml.exe: assembler 
    * link.exe: linker

### Linux (Tested on Ubuntu 11.10)

* [wine](http://www.winehq.org/download/) (1.3 or greater, may work with 1.2)

See **APPENDIX A** for more information about installing and running MASM32 in 
Linux.

## 3. Installation
The goal is to build w32evol.exe.  Makefiles for Windows and Linux are 
included.  The following instructions do not place w32evol.exe in your PATH.

### Linux (Tested on Ubuntu 11.10)

	$ make install

If you want to install this program, then you can then place this whole
directory tree somewhere where you install non-packaged programs.  The /opt/ 
folder is one example.

### Windows
This batch file builds w32evol.exe. After w32evol.exe is built, you can 
place/install it wherever you please.

	> make.bat

*Note 1* This build process assumes that your Windows drive volume is labeled 
"C:".  If your drive volume is labeled something else, for example, "Z:", then 
you have to update the include paths in the src/w32evol.asm file.

## 4. Usage
**in.bin**: input file; exists; contains x86 instructions encoded in raw binary
code

**out.bin**: output file; create if does not exist; obfuscated x86 instructions
encoded in raw binary code 

## Linux

	$ wine path/to/w32evol.exe <in.bin> <out.bin>

## Windows

	>path/to/w32evol.exe <in.bin> <out.bin>

## Usage: Example 1
In this example, we use w32evol.exe to obfuscate (or transform) an instruction 
to an equivalent instruction in the Intel x86 instruction set. Unfortunately, 
the obfuscation engines added three extra bytes (00 00 00), and changed the 
semantics.  This demonstrates that some obfuscation engines have bugs.

	$ ndisasm in.bin
	00000000  83C00A            add ax,byte +0xa
	$ wine w32evol.exe in.bin out.bin
	$ ndisasm out.bin
	00000000  81C00A00          add ax,0xa
	00000004  0000              add [bx+si],al


## 5. Development
* Original Author: 	Unknown
* Author: 					[Martin Velez](http://www.martinvelez.com)
* Copyright: 				Copyright (C) 2012 [Martin Velez](http://www.martinvelez.com)
* License: 					[GPL](http://www.gnu.org/copyleft/gpl.html)

### Source 
[Bitbucket](https://bitbucket.org/martinvelez/w32evol/src) is hosting this code.
	
	https://bitbucket.org/martinvelez/w32evol/src

### Issues
Provide feedback, get help, request features, and report bugs here:

	https://bitbucket.org/martinvelez/w32evol/issues

### Acknowledgements
* [Orr](http://www.antilife.org/files/Evol.pdf)
    * wrote an [article](www.openrce.org/articles/full\_view/27) in which described 
      how he disassembled the metamorphic engine used in the W32.Evol virus
    * He was kind enough to email his disassembled code.  
* [VX Heavens](http://vx.netlux.org/vl.php?dir=Virus.Win32.Evol)
    * Disassembled source code obtained from orriscariot@gmail.com.  Some of his 
      functions contained errors which cause the program to fail.  We obtained 
      executabled code from http://vx.netlux.org/vl.php?dir=Virus.Win32.Evol, and 
      disassembled it using IDA Pro.  We found the mistakes in the disassembled 
      source code and corrected them.

## 6. APPENDIX A: MASM32 and wine
It is possible to use MASM32 in Linux using wine.  When you download MAMS32, 
you get an installer file, install.exe.  Use wine to run that installer.  

	$ cd ~/Downloads
	$ ls
	install.exe
	$ wineconsole install.exe

I have installed MASM32 using wine in two different Ubuntu machines and the 
MASM32 libraries have not been built successfully in either machine.  I had 
to build the libraries myself.

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
	user@host:~/.wine/drive_c/masm32$ wine cmd
	CMD Version 1.3.28

	Z:\home\user\Downloads>makelibs.bat

In one machine, this proceeded without a problem.  In another machine, I had 
to increase 'ulimit -n' from 1024 to 4096 because, apparently, wine was 
opening too many files.


