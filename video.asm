;Writes a string starting from [SI]
; and ending with 0
;can use colours as with printchar (CX)
printstr:
  push ax
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

;puts the cursor on the next line
newline:
  mov byte [xpos],0
  add byte [ypos],1
ret

xpos dw 0
ypos dw 0

clearscreen:
  push ax
  push bx
  push dx
  ;first, destroy bios cursor
  mov al, 0x2
  mov dx,0x50
  int 0x10
  
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
  pop dx
  pop bx
  pop ax
ret

;prints a single character. character is in ax
;font color is ch (see colour enum)
;background color is cl
;background color may not be more than grey
printchar:
  push ax
  push bx
  push cx
  ;prepare colour
  shl cl,4
  add cl,ch
  xor ch,ch
  ;new lines are interpreted as such, and not displayed
  cmp ax,0xA
    je .nl
    
  mov bx,0xb800
  mov es,bx
  
  mov bx,[ypos]
  imul bx,0x50
  add bx,[xpos]
  shl bx,1
  mov [es:bx], ax
  mov [es:bx+1],cx
  ;advance cursor
  cmp word [xpos],0x50
    jne .skip
      jmp .nl
    .skip:
      inc word [xpos]
    jmp .end
.nl:
  mov word [xpos],0
  inc word [ypos]
.end:
  pop cx
  pop bx
  pop ax
ret
colour:
.black db 0x0
.dblue db 0x1
.dgreen db 0x2
.turq db 0x3
.red db 0x4
.purple db 0x5
.brown db 0x6
.grey db 0x7
.dgrey db 0x8
.blue db 0x9
.green db 0xA
.aqua db 0xB
.orange db 0xC
.pink db 0xD
.yellow db 0xE
.white db 0xF
