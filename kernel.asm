call clearscreen
mov si,string ;stream input pointer register
call printstr
xor cx,cx
.loop:
  call digit_to_string
  call printchar
  add cx,1
  cmp cx,10
jne .loop


jmp end
string db 'Test string',10,'How are you?',0
end:
