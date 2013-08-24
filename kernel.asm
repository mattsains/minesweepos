;kernel goes here
call clearscreen

mov byte cl,[colour.brown]
mov byte ch,[colour.green]
mov si,colourful
call printstr

jmp end
;data section
colourful db "This is a nice colour!",10,0
end:
