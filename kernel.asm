;call clearscreen
;mov si,string ;stream input pointer register
;call printstr
;xor cx,cx
;.loop:
;  call digit_to_str
;  call printchar
;  add cx,1
;  cmp cx,10
;jne .loop

mov ax,1234
mov bx,data
call int_to_str
mov si,bx
call printstr

jmp end
string db 'Test string',10,'How are you?',0
end:
