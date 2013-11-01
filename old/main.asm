[BITS 16]    ; generate 16bit opcode

[ORG 0x7c00] ; where are we in memory?

main: ;entry point
  mov ax,0x0000
  mov ds,ax ;set segment register
  
  ;call some initialization functions (eg interrupt setters)
  cli
    call key_init ;keyboard
  sti
  
  ;kernel begins here
  %include "kernel.asm"

  jmp $ ; jump here (infinite)

%include "video.asm"
%include "keyboard.asm"
%include "types.asm"
%include "minesweep.asm"

data: ;place for variables
times 510-($-$$) db 0 ; 510-(here-7c00)
dw 0xAA55 ;boot signature

;padding for floppy
times 1474048 db 0
