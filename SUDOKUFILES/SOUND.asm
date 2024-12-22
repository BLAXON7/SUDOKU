org 0x0100
jmp start

DELAY:  ;delay of 1/18.2 seconds
        push bp
        mov bp, sp
        push cx
        push ax

        DF_l1:                              ;outer loop
            cmp word[bp+4], 0
            je DF_end
            mov ax, 0x0001
            DF_l2:
            mov cx, 0xFFFF
                DS_l3: loop DS_l3           ;inner loop
            dec ax
            jnz DF_l2
            dec word[bp+4]
            jmp DF_l1
        DF_end:
        pop ax
        pop cx
        pop bp
        ret 2
sound:
        ;load the counter 2 value for d3
        ;push bx

        PUSH BP
        MOV BP, SP
        PUSHA

        out 42h, al
        mov al, ah
        out 42h, al
        
        ;turn the speaker on
        in al, 61h
        mov ah,al
        or al, 3h
        out 61h, al
        mov bx, 5

        mov bx,[bp+4]

        push bx
        call DELAY
        
        mov al, ah
        out 61h, al

        POPA
        MOV SP, BP
        POP BP
        ret 2

        ;pop bx
        ret


rowcolsound:
        push ax

        mov ax,2000
        PUSH 3
        call sound

        mov ax,2000
        PUSH 10
        call sound
        mov ax,7000

        pop ax

        push ax

        mov ax,5000
        PUSH 3
        call sound

        mov ax,5000
        PUSH 10
        call sound
        mov ax,7000

        pop ax
        ret


correctinput:
        push ax

        mov ax, 9000 ; G5
        PUSH 3
        call sound
        ;mov ax, 1522 ; G5

        pop ax
        ret

wronginput:
        push ax

        mov ax, 700
        PUSH 13
        call sound

        pop ax
        ret

losegamesound:
        push ax

        mov ax, 1000
        PUSH 3
        call sound

        mov ax, 2000
        PUSH 3
        call sound

        mov ax, 3000
        PUSH 3
        call sound

        mov ax, 4000
        PUSH 3
        call sound


        mov ax, 5000
        PUSH 3
        call sound


        mov ax, 6000
        PUSH 3
        call sound


        mov ax, 7000
        PUSH 3
        call sound

        pop ax
        ret

wingamesound:
        push ax

        mov ax, 7000
        PUSH 3
        call sound


        mov ax, 6000
        PUSH 3
        call sound

        mov ax, 5000
        PUSH 3
        call sound

        mov ax, 4000
        PUSH 3
        call sound

         mov ax, 3000
        PUSH 3
        call sound

        mov ax, 2000
        PUSH 3
        call sound


        mov ax, 1000
        PUSH 3
        call sound

        mov ax, 7000
        PUSH 15
        call sound

        pop ax
        ret
start:
    ; call rowcolsound
    ;call correctinput
    call wronginput
    ;call wingamesound
    ;call losegamesound

    mov ax,0x4c00
    int 21h
    
