;kernel goes here
call clearscreen
xor dx,dx
.loop:
  cmp dx, 0xa
   je end
  mov ax,1
  mov cx,0xa
  call rand
  mov bx, [rnum]
  call int_to_str
  mov si,bx
  mov cl, [colour.black]
  mov ch, [colour.white]
  call printstr
  mov ax,0xa
  call printchar
  inc dx
 jmp .loop

;data section
rnum:
dw 0,0,0,0,0
end:
