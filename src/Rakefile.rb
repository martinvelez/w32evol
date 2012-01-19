#This file builds the windows executable file using MASM build tools.

require 'rake/clean'

CLEAN.include( '*.ilc', '*.ild', '*.ilf', '*.ils', '*.map', '*.tds', '*.xxx', '*.obj', '*.exe', 'mllink$.lnk' )

# EXE Version
file 'w32evol.obj' => ['w32evol.asm', 'engine.asm', 'helper_functions.asm'] do
	sh 'ml /nologo /c /coff w32evol.asm'
end

file 'w32evol.exe' => ['w32evol.obj'] do
	sh 'link /SUBSYSTEM:CONSOLE w32evol.obj'
end


desc "build an executable version of W32/w32evol"
task :w32evol => ["w32evol.exe"]
