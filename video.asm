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
    
    cmp word [xpos],0x50
    jne .skip
      mov word [xpos],0
      inc word [ypos]
    jmp .nextchar
    .skip:
      inc word [xpos]
    jmp .nextchar
  
  .break:
  ret

;sets the print cursor to start
resetcursor:
  mov word [xpos],0
  mov word [ypos],0
ret
xpos dw 0
ypos dw 0

clearscreen:
  mov bx,0xb800
  mov es,bx
  xor bx,bx
  .loop:
    cmp bx,0xfa0;end of screen
    je .end
    
    mov word [es:bx],0
    inc bx
    jmp .loop
  .end:
ret

;prints a single character
printchar:
  mov bx,0xb800
  mov es,bx
  
  xor bx,[ypos]
  imul bx,0x50
  add bx,[xpos]
  imul bx,0x2
  add ax,0x0700;white on black
  mov [es:bx], ax
ret
  
