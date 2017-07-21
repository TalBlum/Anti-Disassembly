; Tal Blum (blum.tal2@gmail.com)
;
; The jz in this code is not conditional and will always jump.
; This code is jumping into itself causing the execution of the operand
; At xor al, 0xEB, which is also an opcode for "jmp". and it jumps 0x24 bytes forward
; to Message. 0x24 is also the opcode "and, al" which is executed at the beginning of the program.
; Therefore it will always jump to Message and never to Fake, and will be very hard to detect.
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
xor al, 0ebh
and al, 0
xor eax, eax
nop
nop
nop
jz $-8

Fake:
invoke MessageBox, NULL, addr MsgBoxTextFake, addr MsgBoxCaptionFake, MB_OK 
invoke ExitProcess, 0

Message:
invoke MessageBox, NULL, addr MsgBoxText, addr MsgBoxCaption, MB_OK 
invoke ExitProcess, NULL 

end start
