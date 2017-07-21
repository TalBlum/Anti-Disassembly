; Tal Blum (blum.tal2@gmail.com)
;
; This program changes the return address in the stack.
; So instead of returning to the next instruction in the caller function and showing
; The "goodbye" message, when the "ret" instruction is executed it "returns" 0x18 bytes forward - 
; To the good code.
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

call Bad
invoke MessageBox, NULL, addr MsgBoxTextFake, addr MsgBoxCaptionFake, MB_OK 

Bad PROC
add BYTE PTR [esp], 018h
ret
Bad ENDP

Good PROC
invoke MessageBox, NULL, addr MsgBoxText, addr MsgBoxCaption, MB_OK 
inc eax
dec eax
invoke ExitProcess, NULL 
Good ENDP

end start
