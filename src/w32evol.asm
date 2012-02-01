.486
.model flat,stdcall
option casemap:none

include C:\masm32\include\windows.inc
include C:\masm32\include\kernel32.inc
include C:\masm32\include\user32.inc
include C:\masm32\include\masm32.inc

includelib C:\masm32\lib\kernel32.lib
includelib C:\masm32\lib\user32.lib
includelib C:\masm32\lib\masm32.lib

.data
success							dd 0
; error codes
errorEngineCrashed 	dd 1
errorUsage 					dd 2
errorOpenFile 			dd 3
errorReadFile 			dd 4 
errorCloseFile 			dd 5
errorCreateFile 		dd 6
errorWriteFile			dd 7
errorEngineAbort 		dd 8

bytesRead				dd 	0
bytesToWrite 		dd 	0
bytesWritten		dd 	0
ibuf 						db 1024 dup (0)			; 10,000 bytes initialized to 0


.data?
obuf					db 1024 dup (?)			; 10,000 bytes initialized to 0

infileName 		db 128 dup (?)
infileHandle 	dd 1 dup (?)
infileSize 		dd 1 dup (?)

outfileName 	db 128 dup (?)
outfileHandle dd 1 dup (?)
outfileSize 	dd 1 dup (?)


.code
include engine.asm
start:
	push offset TopLevelExceptionFilter
	CALL SetUnhandledExceptionFilter
	
	invoke GetCL, 1, addr infileName			; infileName := ARGV[1]
  cmp eax, 1														; 1 = success, 2 = no argument exists at specified arg number, 3 = non-matching quotatin marks, 4 = empty quotation marks
  jne printusage												; if !success, print usage
	invoke GetCL, 2, addr outfileName			; outfileName := ARGV[2]
  cmp eax, 1														; 1 = success, 2 = no argument exists at specified arg number, 3 = non-matching quotatin marks, 4 = empty quotation marks
  jne printusage												; if !success, print usage

readInfile:	
	; open infile and read contents into allocated memory ibuf
	invoke CreateFile, addr infileName, GENERIC_READ, 	0, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
	cmp eax, INVALID_HANDLE_VALUE
	je	openfileError
	mov infileHandle, eax									; save file handle
	
	invoke GetFileSize, eax, 0
	mov infileSize, eax										; save size of file
	
	lea ecx, bytesRead
	invoke ReadFile, infileHandle, addr ibuf, infileSize, ecx, 0
	xor eax, 0
	jz readfileError
	
	invoke CloseHandle, infileHandle
	cmp eax, 0														;If the function succeeds, the return value is nonzero.
	je closefileError
	
callengine:
	push offset obuf
	push infileSize
	push offset ibuf
	call MetaEngine
	cmp eax, 0														; engine returns 0 if it aborts/fails
	je engineFailed
	mov bytesToWrite, eax
	
writetofile:	
	; open infile and write contents from outbuf
	invoke CreateFile, addr outfileName, GENERIC_WRITE, 	0, 0, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
	cmp eax, INVALID_HANDLE_VALUE
	je	createfileError
	mov outfileHandle, eax								; save file handle

	lea ecx, bytesWritten
	invoke WriteFile, outfileHandle, addr obuf, bytesToWrite, ecx, 0
	cmp eax, 0	;If the function succeeds, the return value is nonzero (TRUE).
	je writefileError
	
	invoke CloseHandle, outfileHandle
	cmp eax, 0	;If the function succeeds, the return value is nonzero.
	je closefileError
	
	mov eax, success											; program exit code := success	
	jmp close
		
printusage:
	mov eax, errorUsage
	jmp close
	
openfileError:
	mov eax, errorOpenFile
	jmp close

readfileError:
	mov eax, errorReadFile
	jmp close

closefileError:
	mov eax, errorCloseFile
	jmp close
	
createfileError:
	mov eax, errorCreateFile
	jmp close

writefileError:
	mov eax, errorWriteFile
	jmp close
	
engineFailed:
	mov eax, errorEngineAbort
	jmp close
	
close:
	invoke ExitProcess, eax							; return engine exit code

TopLevelExceptionFilter:
	mov eax, 1	; 1 == do not display error closure box
	ret
end start
