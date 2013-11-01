key_init: ;initialized keyboard input
    mov [0x26],ds
    mov word [0x24],isr_key
    push ax
    mov al, 0xaa
    out 0x64, al ;force a keyboard test (needed for VM)
    in al,0x64 ;kb status reg
    and al,0xB4 ;masks errors
    xor al,0x14 ;flip bits which are the wrong way round for jz
     jz .checkexists ; were none of those zero?
      call clearscreen
      mov si,kb_broken
      call printstr
      jmp $
    .checkexists:
    in al,0x64
    and al,0x40 ;checks for timeout=>no kb
     jz .end
      call clearscreen
      mov si,kb_not_found
      call printstr
      jmp $
.end:
    pop ax
ret

isr_key: ; IRQ 1 -> interrupt 9
  push ax
  push bx
  push si
  in al, 0x60
  mov ah,al
  and al, 0x80
   jnz .end
  mov al, ah

 .end:
  mov al, 0x61
  out 0x20, al;reset interrupt
  pop si
  pop bx
  pop ax
iret
kb_broken db "PS/2 keyboard appears broken",10,0
kb_not_found db "No PS/2 keyboard was found",10,0
