;Writes a string starting from [SI]
; and ending with 0
printstr:
  push ax
  call resetcursor
  .nextchar:
    xor ax,ax
    lodsb ;loads next [SI] into AL
    or al,al ;is AL zero?
      jz .break
    call printchar
  jmp .nextchar
  
  .break:
  pop ax
  ret

;sets the print cursor to start
resetcursor:
  mov word [xpos],0
  mov word [ypos],0
ret
xpos dw 0
ypos dw 0

clearscreen:
  push bx
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
  call resetcursor
  pop bx
ret

;prints a single character. character is in ax
printchar:
  push bx
  push ax
  cmp ax,0xA ;new line
    je .nl
    
  mov bx,0xb800
  mov es,bx
  
  mov bx,[ypos]
  imul bx,0x50
  add bx,[xpos]
  shl bx,1
  add ax,0x0700;white on black
  mov [es:bx], ax
  ;advance cursor
  cmp word [xpos],0x50
    jne .skip
      mov word [xpos],0
      inc word [ypos]
    jmp .end
    .skip:
      inc word [xpos]
    jmp .end
.nl:
  mov word [xpos],0
  add word [ypos],1
.end:
pop ax
pop bx
ret
  
