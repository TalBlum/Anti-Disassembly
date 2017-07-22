; Tal Blum (blum.tal2@gmail.com)
;
; This program is using a stealthy method to dynamcially load a windows function, using LoadLibrary and GetProcAdress.
; It sends the name of the function to GetProcAddress with the instruction "call".
; When "call" is executed, a return address, which is a pointer to the next instruction is pushed onto the stack.
; This program abuses it and since after the call there is a string, actually a pointer to the string is pushed.
; That is the name of the windows function that it wants to load.
; The callee uses that "return address" as a parameter to GetProcAddress instead of an address to return to.
; All that is left is to push the 2nd required parameter - a pointer to the dll, and execute GetProcAddress.
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
