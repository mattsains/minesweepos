call clearscreen
;mov si,string ;stream input pointer register
;call printstr
;xor cx,cx
;.loop:
;  call digit_to_str
;  call printchar
;  add cx,1
;  cmp cx,10
;jne .loop

mov ax,0x1000
.loop:
  mov bx,data
  call int_to_str
  mov si,bx
  call printstr
  call newline
  add ax,1
 cmp ax,0x100a
 jne .loop


jmp end
string db 'Test string',10,'How are you?',0
end:
