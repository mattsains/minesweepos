;Clears video memory - and the screen
clearscreen:
  push ebx
  push edx ;so many vars just for a clear function
  
  mov ebx, 0xb8000 ;start of video memory
  xor edx, edx ;zero constant
  .loop:
    mov [ebx], edx
    add ebx, 32
    cmp ebx, 0xb8fa0 ;end of video memory
    jne .loop
  ;and some convenience:
  mov byte [xpos], 0
  mov byte [ypos], 0
  
  pop edx
  pop ebx
ret

;Prints a single character. 
;Character in ax
;foreground colour in ch
;background in cl (not bigger than grey)
printchar:
  push ebx
  push ecx
  
  ;condense (ch,cl) into cl
  shl cl, 4
  add cl, ch
  
  ;handle newlines \n, 0xA, 10d
  cmp ax, 0xa
    je .newline
  
  xor ebx, ebx
  mov bx, [ypos]
  imul bx, 80 ;characters per line
  add bx, [xpos]
  shl bx, 1 ;two bytes per character
  add ebx, 0xb8000 ;start of vid mem
  mov byte [ebx], al
  mov byte [ebx+1], cl
  
  ;advance cursor
  cmp byte [xpos], 80 ;end of the line
    je .newline
    inc byte [xpos]
  
  jmp .end
    .newline: ;handle new lines
    inc byte [ypos]
    mov byte [xpos], 0
    
  .end:
  pop ecx
  pop ebx
ret

;Writes a string starting from [ESI]
;Can use the same colours as printchar (CX)
;Does not maintain ESI
printstr:
  push ax
  
  .loop:
    lodsb
    cmp al, 0 ;end of string
      je .end
    call printchar
  jmp .loop
  
  .end:
  pop ax
ret

;cursor position
xpos db 0
ypos db 0

;colour enum
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
