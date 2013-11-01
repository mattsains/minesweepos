;multiboot stuff
MBALIGN   equ 1<<0
MEMINFO   equ 1<<1
FLAGS     equ MBALIGN | MEMINFO
MAGIC     equ 0x1BADB002
CHECKSUM  equ -(MAGIC + FLAGS)

section .multiboot
align 4
  dd MAGIC
  dd FLAGS
  dd CHECKSUM
  
;start a stack going
section .bootstrap_stack
align 4
  stack_bottom:
    times 16384 db 0
  stack_top:

;aaand code
section .text
  global _start
  _start:
    ;main entry point for the program
    mov esp, stack_top ; set up that stack
    xchg bx, bx ;magic breakpoint for debug
    
    ;code here
    call clearscreen
    
    cli
    .hang:
      hlt
    jmp .hang

  ;I think I'll put libraries here
  %include "video.asm"
