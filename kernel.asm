mov si,string ;stream input pointer register
call printstr

jmp end
string db 'Test string',13,10,0;13=\r 10=\n
end:
