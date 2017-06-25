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
DLL db  "user32.dll",0

.code

start:

push offset DLL
call LoadLibrary
call Bad
db "MessageBoxA",0

Bad PROC
push eax
call GetProcAddress
push 0 
push offset MsgBoxText
push offset MsgBoxCaption
push MB_OK
call eax
invoke ExitProcess, NULL 
Bad ENDP

end start