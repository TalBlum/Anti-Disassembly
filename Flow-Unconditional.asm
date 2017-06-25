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
stc
jc Fake
db 0E8h

Fake:
jmp Message
invoke MessageBox, NULL, addr MsgBoxTextFake, addr MsgBoxCaptionFake, MB_OK 
invoke ExitProcess, 0

Message:
invoke MessageBox, NULL, addr MsgBoxText, addr MsgBoxCaption, MB_OK 
invoke ExitProcess, NULL 

end start