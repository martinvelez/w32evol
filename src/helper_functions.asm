;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;These functions were not originally found in disassembly of w32/Evol
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;function that generates a random number
Random proc near
	push ebp
	mov ebp, esp
	push ebx
	call GetTickCount
	mov eax, [ebx+14h]
	push eax
  call FormatRandomSeed
	mov [ebx + 14h], eax
	pop ebx
	pop	ebp
	ret
Random endp



;helper function for Random number generator
FormatRandomSeed  proc 
	push    ecx
	push    edx
	xor     edx, edx
	mov     ecx, 7FFFFD9h
	mul     ecx
	xor     eax, 18Ah
	mov     ecx, 0FFFFFFFBh
	div     ecx
	mov     eax, edx
	pop     edx
	pop     ecx
	ret				4
FormatRandomSeed  endp

;wrapper function for VirtuallAlloc
callVirtualAlloc proc 
dwSize           = dword ptr  8
	; print "callVirtualAlloc", 10, 13
	push    ebp												; standard entry sequence: save the value of ebp
	mov     ebp, esp								; ebp now points to the top of the stack
	push    4														; DWORD flProtect = PAGE_READWRITE
	push    1000h										; DWORD flAllocationType = MEM_COMMIT
	mov     eax, [ebp+dwSize]
	push    eax												; DWORD dwSize = bytes to allocate
	push    0														; LPVOID lpAddress = NULL
	call    VirtualAlloc								; LPVOID VirtualAlloc(LPVOID lpAddress, DWORD dwSize, DWORD flAllocationType, DWORD flProtect ); 
	pop     ebp
	retn   4
callVirtualAlloc endp

;wrapper function for VirtuallFree
callVirtualFree proc near
lpAddress           = dword ptr  8
	; print "callVirtualFree", 10, 13
	push    ebp													; standard entry sequence: save the value of ebp
	mov     ebp, esp									; ebp now points to the top of the stack
	push    8000h											; __in  DWORD dwFreeType = MEM_RELEASE
	push    0															;  __in  SIZE_T dwSize = 0
	mov     eax, [ebp+lpAddress]
	push    eax													; __in  LPVOID lpAddress
	call    VirtualFree									;BOOL WINAPI VirtualFree(__in  LPVOID lpAddress,  __in  SIZE_T dwSize,  __in  DWORD dwFreeType);
	pop     ebp
	ret			4
callVirtualFree endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
