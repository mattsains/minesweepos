;Writes a string starting from [SI]
; and ending with 0
printstr:
  mov ah,0x0e ;print function
  mov bh,0x0  ;page num?
  mov bl, 0x07;normal text
  .nextchar:
    lodsb ;loads next [SI] into AL
    or al,al ;is AL zero?
      jz .break
    int 0x10;print char
  jmp .nextchar
  
  .break:
  ret
