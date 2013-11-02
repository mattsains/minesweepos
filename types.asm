;a digit in cl becomes an ascii number in al
digit_to_char:
  mov al, cl
  add al, 0x30
ret

;Takes an unsigned integer in eax and converts it to a string starting at [ebx]
int_to_str:
  push eax
  push ebx
  push ecx
  push edx
  call _int_to_str
  mov byte [ebx], 0 ;zero terminated string
  pop edx
  pop ecx
  pop ebx
  pop eax
ret

_int_to_str:
  xor edx, edx ;clear edx in preparation for a div remainder
  push ecx ;need to use this for division
    ;divide our integer by ten so we can get the remainder (decimal )LSB
    mov ecx, 0xa
    div ecx
  pop ecx
  ;dl is the digit to be processed when recursion completes
  push dl
  and eax, eax ;recurse unless there is nothing left to divide
    jz .break
    call _int_to_str
  .break:
  pop cl
  call digit_to_char
  mov [ebx], al
  inc ebx
ret
