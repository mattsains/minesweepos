call clearscreen
mov si,string ;stream input pointer register
call printstr

jmp end
string db 'Test string',0
end:
