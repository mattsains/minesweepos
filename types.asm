;whatever is in cx becomes a ascii digit in ax
digit_to_string:
  mov cx,ax
  add ax,0x30
ret

;takes an integer ax and converts it into a string starting at [bx]
int_to_string:
  push ax
  push bx;not really necessary but let's make this function isolated
  push cx
  push dx
  push 0; hack to end the string with a term
  call int_to_string_rec
  pop dx
  pop cx
  pop bx
  pop ax
ret

int_to_string_rec:
  xor dx,dx;if we clear dx, it should get the mod when we divide
  ;TODO: div works differently, see http://en.wikibooks.org/wiki/X86_Assembly/Arithmetic
  div ax,0xa;divide ax by 10
  push dx;store the remainder before recurse
  cmp ax,0;if we've fully divided, stop recursing.
  je .break
    call int_to_string_rec
  .break:
  pop cx ;get the next remainder into cx
  call digit_to_string;now ax is the ascii of cx
  mov [bx],ax ;store ascii in the next position in string
  inc bx ;get ready for the next one which will happen when we drop recursive levels
ret
