# w32evol -- x86 obfuscation engine
- - -

* Original Author: 	Unknown
* Author: 					[Martin Velez](http://www.martinvelez.com)
* Copyright: 				Copyright (C) 2011 [Martin Velez](http://www.martinvelez.com)
* License: 					[GPL](http://www.gnu.org/copyleft/gpl.html)

## Description 

This repository contains a command line interface to the obfuscation engine 
used by the W32.Evol virus.

The Win32.Evol virus appeared around July 2000 and was able to infect any major
Win32 platform.  It used a metamorphic engine to rewrite its code during
replication.  The purpose of its metamorphic engine was to create mutated
copies of itself.  Hence, some of the transformations or rewritings it applies
to instructions do not necessarily obfuscate.  Here is a more detailed
description of the virus:
[Symantec](http://www.symantec.com/security_response/writeup.jsp?docid=2000-122010-0045-99).

We wrote evol.asm which drives the W32.Evol obfuscation engine and provides a 
command line interface.

## Dependencies

### General

* [MAMS32](http://www.masm32.com/)
    * ml.exe: assembler 
    * link.exe: linker

### Linux (Tested on Ubuntu 11.10)

* [wine](http://www.winehq.org/download/) (>= 1.3 or greater, may work with 1.2)

## Installation

The goal is to build w32evol.exe.  You can then place/install this executable 
wherever you please.  

Files to build w32evol.exe in Windows and Linux are included.

### Linux (Tested on Ubuntu 11.10)

	$ make

### Windows
 
	> make.bat

## Usage

	w32evol.exe *in.bin* *out.bin*

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
{Bitbucket}(https://bitbucket.org/martinvelez/w32evol/src)

## Acknowledgements
* {Orr}(http://www.antilife.org/files/Evol.pdf)
  * wrote an {article}[www.openrce.org/articles/full_view/27] in which described 
    how he disassembled the metamorphic engine used in the W32.Evol virus
  * He  was kind enough to email his disassembled code.  
* {VX Heavens}[http://vx.netlux.org/vl.php?dir=Virus.Win32.Evol]
  * Disassembled source code obtained from orriscariot@gmail.com.  Some of his 
    functions contained errors which cause the program to fail.  We obtained 
    executabled code from http://vx.netlux.org/vl.php?dir=Virus.Win32.Evol, and 
    disassembled it using IDA Pro.  We found the mistakes in the disassembled 
    source code and corrected them.



