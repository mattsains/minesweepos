;whatever is in cx becomes a ascii digit in ax
digit_to_str:
  mov ax,cx
  add ax,0x30
ret

;takes an integer ax and converts it into a string starting at [bx]
int_to_str:
  push ax
  push bx;not really necessary but let's make this function isolated
  push cx
  push dx
  call int_to_str_rec
  mov byte [bx], 0x00 ;zero termination
  pop dx
  pop cx
  pop bx
  pop ax
ret

int_to_str_rec:
  xor dx,dx;if we clear dx, it should get the mod when we divide
  ;dividend/divisor=quotient
  push cx
  mov cx,0xa;division needs to happen to registers
  div cx;divide ax by 10
  pop cx
  push dx;store the remainder before recurse
  cmp ax,0;if we've fully divided, stop recursing.
  je .break
    call int_to_str_rec
  .break:
  pop cx ;get the next remainder into cx
  call digit_to_str;now ax is the ascii of cx
  mov [bx],al ;store ascii in the next position in string
  inc bx ;get ready for the next one which will happen when we drop recursive levels
ret
