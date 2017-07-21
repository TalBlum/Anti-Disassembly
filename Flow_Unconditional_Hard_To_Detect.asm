; Tal Blum (blum.tal2@gmail.com)
;
; This method is similar to Flow_Uncoditional
; Only that this example uses an always True statement
; That is harder to detect and is not universally True.
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
mov esi, OFFSET MsgBoxCaption
mov al, "H"
cmp BYTE PTR [esi], al
jz Real_Code
db 0E8h

Real_Code:
jmp Message
invoke MessageBox, NULL, addr MsgBoxTextFake, addr MsgBoxCaptionFake, MB_OK 
invoke ExitProcess, 0

Message:
invoke MessageBox, NULL, addr MsgBoxText, addr MsgBoxCaption, MB_OK 
invoke ExitProcess, NULL 

end start
