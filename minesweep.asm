%assign width	0x10
%assign height 10
;checks if a grid index is a mine
;[cl,ch]
;sets zero flag if clear
ismine:
  push ax
  push bx
  push cx
  
  xor bx,bx
  mov bl,ch
  mov ax,width
  
  mul bx ;bx is now width*x
  
  xor ch,ch
  add bx,cx ;bx is now position*8
  push bx
  shr bx,8
  mov ax, [minefield+bx]
  pop cx ;neat trick using cl as bit shift count
  push cx
  
  mov bx,1
  shl bx,cl ;bx is now bitselector
  and cx,ax ;this sets zero flag if mine is clear
  
  pop cx
  pop bx
  pop ax
ret

;sets the mine [cl,ch] to al[0]
setmine:
  push ax
  push bx
  push cx
  
  xor bx,bx
  mov bl,ch
  mov ax,width
  
  mul bx ;bx is now width*x
  
  xor ch,ch
  add bx,cx ;bx is now position*8
  push bx
  shr bx,8
  pop cx ;neat trick using cl as bit shift count
  push cx
  
  push ax 
  mov ax,0x1
  shl ax,cl
  not ax
  and [minefield+bx],ax ;unset the bit
  
  pop ax
  and ax,0x1
  shl ax,cl
  or [minefield+bx],ax ;conditionally set the bit
    
  pop cx
  pop bx
  pop ax
ret

;randomizes mines
initfield:
  push ax
  push bx
  push cx
  
  xor ax,ax
  mov cx,0xFF
  
  mov bx,minefield
  xchg bx,bx
  .loop:
    cmp bx,minefield.end
     je .end
    call rand
    mov [bx],ax
    inc bx
  jmp .loop
  .end:
  pop cx
  pop bx
  pop ax
ret

;bitmap of minefield, 10x10
minefield:
  times (width*height)/8 db 0
.end:
