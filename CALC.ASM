.model small
.stack 100h

.data
        msg db 'Calculator starting. . . ',13,10,'$'

.code
main proc
        mov ax, @data
        mov ds, ax

        ;print message
        mov ah, 09h
        lea dx, msg
        int 21h

        ;wait for key
        mov ah, 00h
        int 16h

        ;exit to dos
        mov ah, 4ch
        mov al, 00h
        int 21h
main endp
end main
