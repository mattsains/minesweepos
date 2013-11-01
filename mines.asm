;14MiB of memory far from weird memory mapping and important bits
;ironically the only place in memory that *isn't* a minefield
%define minefield 0x100000

;an experiment in "OOP"
;minefield:
  .boundry dd 0 ;memory address of end of minefield
  .length db 0 ; <-->
  .height db 0 ; ^
               ; |
               ; v
  
  ;Initializes a minefield.
  ;Length in al, height in ah
  .init:
    push eax
    push bx
    
    mov byte [.length], al
    mov byte [.height], ah
    
    ;multiply ah by al and store it in ax
    mul ah
    mov bl, al ;keep the small bits for later
    
    shr ax, 3 ;we're talking about bits here, not bytes
    mov [.boundry], ax
    
    ;test if the boundry is exact, or we need to reserve another half-byte
    shl ax, 3
    cmp al, bl
      je .noadd
    
    add dword [.boundry], 1
    .noadd:
    add dword [.boundry], minefield
    
    ;blank out the minefield
    mov eax, minefield
    .loop:
      mov word [eax], 0
      add eax, 32 ;next word
      cmp eax, [.boundry]
        jb .loop ;jump if below, unsigned <
    pop bx
    pop eax
  ret
  
  ;sets the zero flag if the mine is clear
  ;Length in al [-] , height in ah [|]
  .ismine:
    push eax
    push ecx
    
    mov cx, ax ;clear eax for operations
    xor eax, eax
    
    mov al, ch
    mov ch, [.length]
    mul ch
    xor ch, ch
    add ax, cx ;now ax is ah*length+al
    
    mov ecx, eax ;put ax back into bx
    
    shr eax, 3
    add eax, minefield
    mov al, [eax]
    
    ;figure out position in the byte
    and cl, 0b111
    ;now construct the bitmask for al
    mov ch, 1
    shl ch, cl
    
    ;compare and set/unset zero flag
    and al, ch
    ;and we're done
    
    pop ecx
    pop eax
  ret


