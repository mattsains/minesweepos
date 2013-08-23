key_init: ;initialized keyboard input
    mov [0x24],ds
    mov word [0x26],isr_key
    push ax
    ;TODO: force a basic assurance test for virtual machine compatibility
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
    and al,0x40;checks for timeout=>no kb
     jz .end
      call clearscreen
      mov si,kb_not_found
      call printstr
      jmp $
.end:
ret

isr_key: ;interrupt 9
pusha
  in al, 0x60
popa
iret

kb_broken db "PS/2 keyboard appears broken",10,0
kb_not_found db "No PS/2 keyboard was found",10,0
