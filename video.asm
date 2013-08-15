;Writes a string starting from [SI]
; and ending with 0
printstr:
  call resetcursor
  .nextchar:
    xor ax,ax
    lodsb ;loads next [SI] into AL
    or al,al ;is AL zero?
      jz .break
    call printchar
    add byte [cursor],0x1
  jmp .nextchar
  
  .break:
  ret

;sets the print cursor to start
resetcursor:
  mov byte [cursor], 0x0
ret
cursor dw 0

printchar:
  mov bx,0xb800
  mov es,bx
  
  xor bx,bx
  mov bx,[cursor]
  imul bx,0x2
  add ax,0x0700
  mov [es:bx], ax
ret
  
