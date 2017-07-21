; Tal Blum (blum.tal2@gmail.com)
;
; This code demonstrates the use of pointer tables.
; While it is not only an anti-disassembly technique, using
; Pointer tables does make the process of RE harder.
;

.386 
.model flat,stdcall 
option casemap:none 
include \masm32\include\windows.inc 
include \masm32\include\kernel32.inc 
include \masm32\include\masm32rt.inc
includelib \masm32\lib\kernel32.lib 
include \masm32\include\user32.inc 
includelib \masm32\lib\user32.lib


.data 
MsgBoxCaption  db "Hello",0 
MsgBoxText       db "!",0
MsgBoxCaptionFake  db "Goodbye",0 
MsgBoxTextFake       db "?",0

.code

start:

mov ecx, offset table
mov eax, 1
call word ptr [ecx+eax*4]
invoke ExitProcess, NULL 

Bad PROC
invoke MessageBox, NULL, addr MsgBoxTextFake, addr MsgBoxCaptionFake, MB_OK 
ret
Bad ENDP

Good PROC
invoke MessageBox, NULL, addr MsgBoxText, addr MsgBoxCaption, MB_OK 
ret
Good ENDP

table:
dd OFFSET Bad
dd OFFSET Good

end start
