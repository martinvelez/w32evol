= w32evol -- x86 obfuscation engine

Original Author:: Unknown
Author:: {Martin Velez}[http://www.martinvelez.com]
Copyright:: Copyright (C) 2011 Martin Velez
License:: GPL[http://http://www.gnu.org/copyleft/gpl.html]

== Description 

This repository contains obfuscation engine used by the W32.Evol virus wrapped
in an executable with a command line interface.

The Win32.Evol virus appeared around July 2000 and was able to infect any major
Win32 platform..  It used a metamorphic engine to rewrite its code during
replication.  Here is a more detailed description of the virus: 
Symantec[http://www.symantec.com/security_response/writeup.jsp?docid=2000-122010-0045-99].

== Dependencies

* MAMS32 assembler (ml.exe)
* 
== Installation
This engine was built in Windows XP using the MASM32 assembler (ml.exe).

A rakefile is included for convenience.  The engine does not need to be 
rebuilt.  The executable file, w32evol.exe is found in the bin directory.
The source code is in the src directory.

If you need to rebuild this engine, try to do so under Windows XP.  However, 
you may have luck in Linux using Wine.

== Usage
 w32evol.exe <infile.bin> <outfile.bin>

infile.bin: existing file, contains raw binary code which represents x86 
instructions

outfile.bin: nonexisting file, will contain obfuscated code if no error occurs 
during obfuscation

== Development
=== Source 
Disassembled source code obtained from orriscariot@gmail.com.  Some of his
functions contained errors which cause the program to fail.  We obtained
executabled code from http://vx.netlux.org/vl.php?dir=Virus.Win32.Evol, 
and disassembled it using IDA Pro.  We found the mistakes in the 
disassembled source code and corrected them.

== Acknowledgements
* Orr
  * an OpenRCE.org[www.openrce.org/articles/full_view/27] user
  * wrote an article in which described how he disassembled the metamorphic 
    engine used in the W32.Evol virus
  * He  was kind enough to email his disassembled code.  
* {VX Heavens}[http://vx.netlux.org/vl.php?dir=Virus.Win32.Evol]


We wrote evol.asm which drives the W32/Evol obfuscation engine and provides
an appropriate command line interface.
