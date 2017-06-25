.386 
.model flat,stdcall 
option casemap:none 
include \masm32\include\windows.inc 
include \masm32\include\kernel32.inc 
include \masm32\include\masm32rt.inc
includelib \masm32\lib\kernel32.lib 
include \masm32\include\user32.inc 
includelib \masm32\lib\user32.lib


.code

start:

push 0 
jmp Message
MsgBoxCaption  db "Hello",0 
MsgBoxText       db "!",0
Message:
push 0
push offset MsgBoxText
push offset MsgBoxCaption
push MB_OK
call MessageBox
invoke ExitProcess, 0
end start