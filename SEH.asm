; Tal Blum (blum.tal2@gmail.com)
;
; This code changes the SEH and sets its first function to "Good", so when an execption
; Will occur it will first be handled by the function "Good".
; It then divides by zero and cause an exception - and the execution of "Good" - in a very hard to detect technique.
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

ASSUME FS:NOTHING

start:

Bad PROC

mov eax, offset Bad
add eax, 22h
push eax
push fs:[0]
mov fs:[0], esp
xor eax, eax
div eax
push 0
call ExitProcess

Bad ENDP

Good PROC
push 0
push offset MsgBoxText
push offset MsgBoxCaption
push MB_OK
call MessageBox
push 0
call ExitProcess
Good ENDP

end start
