[org 0x0100]


jmp MAIN_GAME                          ;main on line 1809

%include  "C:\DOSBox-X\code\SUDOKU_BITMAP.asm"       ;TO BE EDITED ON DIFFERENT SYSTEM
%include  "C:\DOSBox-X\code\SOUND.asm"                  ;TO BE EDITED ON DIFFERENT SYSTEM
message : db 'SUDOKU'
message1 : db 'Press Any Button To Continue'
message2 : db '=-=-DIFFICULTY MODE-=-='
message3 : db '1- EASY'
message4:  db '2- MEDIUM'
message5: db '3- HARD'
message6: db '4- EXIT'
message7: db 'TIMER'
message8: db 'THE GAME HAS COME TO AN END'
message9: db 'SCOREBOARD'
message10: db 'ANIMATION BOARD'
message12: db 'EASY'
message13: db 'MISTAKES 0/3'
message15: db 'NEW GAME'
message16: db 'EXIT GAME'
message17: db 'MEDIUM'
message18: db 'HARD'
message19: db 'LOADING...'
message20: db 'MISTAKES 1/3'
message21: db 'MISTAKES 2/3'
message22: db 'MISTAKES 3/3'
mistakeslabel: dw 0
pencil_var: dw 0


inputrow: dw 0
inputcol: dw 0
direction: dw 0
initialinputcoordinatesrow: dw 40
initialinputcoordinatescol: dw 40
pushes: dw 0

seed : dw 0
row: dw 1
col : dw 0
sizeboard: dw 9

matrix: db 00000001b,00000010b,00000011b,00000100b,00000101b,00000110b,00000111b,00001000b,00001001b,
        db 00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,
        db 00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,
        db 00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,
        db 00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,
        db 00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,
        db 00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,
        db 00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,
        db 00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,

 dup_matrix: db 00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,
        db 00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,
        db 00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,
        db 00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,
        db 00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,
        db 00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,
        db 00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,
        db 00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,
        db 00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,00000000b,

difficulty_index: dw 0

length  : dw 6
length1 : dw 28
length2 : dw 23
length3 : dw 7
length4 : dw 9
length5 : dw 7
length6:  dw 7 
length7: dw 5
length8: dw 27
length9: dw 10
length10: dw 15
length12: dw 4
length13: dw 12
length15: dw 8
length16: dw 9
length17: dw 6
length18: dw 4
length19: dw 10
length20: dw 12
length21: dw 12
length22: dw 12

ticks: dw 0
second: dw 0
minutes: dw 0
time: times 5 dw 0
timer_old: dw 0 , 0
key_old: dw 0,0
undo_queue_row: dw 0,0,0
undo_queue_col: dw 0,0,0
score: dw 0


;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS-FUNCTIONS
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
scoreprinter:
    push bp
    mov bp,sp
    pusha 

              mov  ax, [score]         ; load number in ax 
              mov  bx, 10             ; use base 10 for division 
              mov  cx, 0              ; initialize count of digits 
             nextdi:
              mov  dx, 0              ; zero upper half of dividend 
              div  bx                 ; divide by 10 
              push dx                 ; save ascii value on stack 
              inc  cx                 ; increment count of values  
              cmp  ax, 0              ; is the quotient zero 
              jnz  nextdi         ; if no divide it again 


        mov bx,530
        mov di,123

         mov ax,0x01
            push ax
            mov ax,letter_clear
            push ax
            mov ax,530
            push ax
            mov ax,123
            push ax
            call PRINT_NUMBER

             mov ax,0x01
            push ax
            mov ax,letter_clear
            push ax
            mov ax,547
            push ax
            mov ax,123
            push ax
            call PRINT_NUMBER

             mov ax,0x01
            push ax
            mov ax,letter_clear
            push ax
            mov ax,564
            push ax
            mov ax,123
            push ax
            call PRINT_NUMBER


        printingtime:

            pop dx
                        
             cmp dx,0
             je print00
            cmp dx, 1 
            je print11
            cmp dx, 2 
            je print22
            cmp dx, 3 
            je print33
            cmp dx, 4 
            je print44
            cmp dx, 5 
            je print55
            cmp dx, 6 
            je print66
            cmp dx, 7 
            je print77
            cmp dx, 8 
            je print88
            cmp dx, 9 
            je print99

             print00:
            mov ax,0x00
            push ax
            mov ax,letter0
            push ax
            mov ax,bx
            push ax
            mov ax,di
            push ax
            call PRINT_NUMBER
            jmp meowmeow

            print11:
            mov ax,0x00
            push ax
            mov ax,letter1
            push ax
            mov ax,bx
            push ax
            mov ax,di
            push ax
            call PRINT_NUMBER
            jmp meowmeow

            print22:
            mov ax,0x00
            push ax
            mov ax,letter2
            push ax
            mov ax,bx
            push ax
            mov ax,di
            push ax
            call PRINT_NUMBER
            jmp meowmeow
            print33:
            mov ax,0x00
            push ax
            mov ax,letter3
            push ax
            mov ax,bx
            push ax
            mov ax,di
            push ax
            call PRINT_NUMBER
            jmp meowmeow

            print44:
            mov ax,0x00
            push ax
            mov ax,letter4
            push ax
            mov ax,bx
            push ax
            mov ax,di
            push ax
            call PRINT_NUMBER
            jmp meowmeow
            print55:
            mov ax,0x00
            push ax
            mov ax,letter5
            push ax
            mov ax,bx
            push ax
            mov ax,di
            push ax
            call PRINT_NUMBER
            jmp meowmeow

            print66:
            mov ax,0x00
            push ax
            mov ax,letter6
            push ax
            mov ax,bx
            push ax
            mov ax,di
            push ax
            call PRINT_NUMBER
            jmp meowmeow
            print77:
            mov ax,0x00
            push ax
            mov ax,letter7
            push ax
            mov ax,bx
            push ax
            mov ax,di
            push ax
            call PRINT_NUMBER
            jmp meowmeow

            print88:
            mov ax,0x00
            push ax
            mov ax,letter8
            push ax
            mov ax,bx
            push ax
            mov ax,di
            push ax
            call PRINT_NUMBER
            jmp meowmeow  
            print99:
            mov ax,0x00
            push ax
            mov ax,letter9
            push ax
            mov ax,bx
            push ax
            mov ax,di
            push ax
            call PRINT_NUMBER

        meowmeow:    
            dec cx
            add bx,17
            cmp cx,0
            jne printingtime


        popa
        pop bp
        ret




queue_position_insert:
    push bp
    mov bp,sp
    pusha 


    mov ax,[bp+4]   ;col position
    mov dx,[bp+6]  ;row position


    



    normalsave:
    mov bx,[undo_queue_col+2]
    mov [undo_queue_col],bx
    mov bx,[undo_queue_col+4]
    mov [undo_queue_col+2],bx

    mov [undo_queue_col+4],ax


    mov bx,[undo_queue_row+2]
    mov [undo_queue_row],bx
    mov bx,[undo_queue_row+4]
    mov [undo_queue_row+2],bx

    mov [undo_queue_row+4],dx 

    cmp word [pushes],3
    je returneererer
    inc word [pushes]

    returneererer:
    popa
    pop bp
    ret 4

;----------------------------------------------------------------------
jobhi:
        pusha
        mov ax,0x01
        push ax
        mov ax,letter_clear_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,39
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,39
        push ax
        call PRINT_NUMBER_SMALL


        mov ax,0x01
        push ax
        mov ax,letter_clear_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,49
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,39
        push ax
        call PRINT_NUMBER_SMALL

        mov ax,0x01
        push ax
        mov ax,letter_clear_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,59
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,39
        push ax
        call PRINT_NUMBER_SMALL


        mov ax,0x01
        push ax
        mov ax,letter_clear_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,39
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,49
        push ax
        call PRINT_NUMBER_SMALL


        mov ax,0x01
        push ax
        mov ax,letter_clear_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,49
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,49
        push ax
        call PRINT_NUMBER_SMALL


        mov ax,0x01
        push ax
        mov ax,letter_clear_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,59
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,49
        push ax
        call PRINT_NUMBER_SMALL


        mov ax,0x01
        push ax
        mov ax,letter_clear_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,39
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,59
        push ax
        call PRINT_NUMBER_SMALL


        mov ax,0x01
        push ax
        mov ax,letter_clear_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,49
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,59
        push ax
        call PRINT_NUMBER_SMALL


        mov ax,0x01
        push ax
        mov ax,letter_clear_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,59
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,59
        push ax
        call PRINT_NUMBER_SMALL
        
        popa
        ret
;-----------------------------------------------------------------------
undo_val:
    push bp
    mov bp,sp
    pusha

    cmp word [pushes],0
    je exile


    mov cx,[undo_queue_col+4]


    mov bx,[undo_queue_col+2]
    mov [undo_queue_col+4],bx
    mov bx,[undo_queue_col]
    mov [undo_queue_col+2],bx

    mov word [undo_queue_col],0


    mov dx,[undo_queue_row+4]


    mov bx,[undo_queue_row+2]
    mov [undo_queue_row+4],bx
    mov bx,[undo_queue_row]
    mov [undo_queue_row+2],bx

    mov word [undo_queue_row],0

    mov ax,dx     ;calculation of index
        mov bl,9
        mul bl
        add ax,cx
        mov si,ax


        mov byte [matrix+si],0
        

     mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,dx
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,cx
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

        

        dec word [pushes]  
    exile:
    popa
    pop bp
    ret
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;PRINTING TIMER
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
print_time:
    push bp
    mov bp,sp

;SECOND
mov ax, [bp+4]
mov bx, 10
mov cx, 0
nextdigit:
mov dx, 0
div bx
add dl, 0x30
push dx
inc cx
cmp ax, 0
jnz nextdigit

mov ax,9
cmp [bp+4],ax
jg colon
mov dx,'0'
push dx
inc cx

colon:
mov dx,':'
push dx
inc cx

;MINUTES
mov ax, [bp+6]
mov bx, 10
nextdigit1: 
mov dx, 0
div bx
add dl, 0x30
push dx
inc cx
cmp ax, 0
jnz nextdigit1

mov bx,cx
mov si,0
lop:
    pop dx
    mov [time+si],dx
    inc si
    loop lop

mov cx,bx

PUSHA
mov ax,cs
mov es,ax
mov ax,0

mov al,0x00
mov ah,13h
mov bh,0x00
mov bl,0x02         ;color
mov cx,cx
mov dh,3
mov dl,64
mov bp,time
int 10h
POPA

pop bp
ret 4


timer:
    pusha
    inc word [cs:ticks]
    cmp word [cs:ticks],18

    jne returning
    mov word [cs:ticks],0
    inc word [cs:second]
    cmp word [cs:second],60

    jne print_timer
    mov word [cs:second],0
    inc word [cs:minutes]


    print_timer:
        push word [cs:minutes] ;6
        push word [cs:second] ;4
        call print_time
    




returning:
    mov al,0x20
    out 0x20,al
    POPA
    iret
;copying all data into another array


copy_inother:
            PUSHA
            mov cx,81
            mov si,0

            copyed:
            mov al,[matrix+si]
            mov byte [dup_matrix+si],al
            inc si
            loop copyed


        popa
        ret 

checkrow:
    push bp
    mov bp,sp
    pusha


    mov ax,1
    mov [bp+4],ax

    mov ax,[inputcol]
    mov bx,9
    mul bx
    mov si,ax

    mov cx,9

    checkloop:
        cmp byte [matrix+si],0
        jne skipo
        mov ax,0
        mov [bp+4],ax
        skipo:
            inc si
            loop checkloop

    popa
    pop bp
    ret

    checkrcol:
    push bp
    mov bp,sp
    pusha


    mov ax,1
    mov [bp+4],ax

    mov ax,[inputrow]
    mov si,ax

    mov cx,9

    checkloop1:
        cmp byte [matrix+si],0
        jne skipo0
        mov ax,0
        mov [bp+4],ax
        skipo0:
            add si,9
            loop checkloop1

    popa
    pop bp
    ret

printanimation:
        push bp
        mov bp,sp
        pusha

        call rowcolsound

        mov cx,3

    thebigone:
        mov ax,0x02
        push ax
        mov ax,stars
        push ax
        mov ax,83
        push ax
        mov ax,425
        push ax
        call PRINT_NUMBER
        mov ax,0x02
        push ax
        mov ax,stars
        push ax
        mov ax,153
        push ax
        mov ax,435
        push ax
        call PRINT_NUMBER
        mov ax,0x02
        push ax
        mov ax,stars
        push ax
        mov ax,223
        push ax
        mov ax,425
        push ax
        call PRINT_NUMBER
        mov ax,0x02
        push ax
        mov ax,stars
        push ax
        mov ax,293
        push ax
        mov ax,435
        push ax
        call PRINT_NUMBER

        
        pusha 
        
        mov cx,0x10
        great:
        push cx
        mov cx,0xffff
        greater:
            loop greater
            pop cx
            loop great       
            
        popa 

    

        removeprev:
         mov ax,0x00
        push ax
        mov ax,stars
        push ax
        mov ax,83
        push ax
        mov ax,425
        push ax
        call PRINT_NUMBER
        mov ax,0x00
        push ax
        mov ax,stars
        push ax
        mov ax,153
        push ax
        mov ax,435
        push ax
        call PRINT_NUMBER
        mov ax,0x00
        push ax
        mov ax,stars
        push ax
        mov ax,223
        push ax
        mov ax,425
        push ax
        call PRINT_NUMBER
        mov ax,0x00
        push ax
        mov ax,stars
        push ax
        mov ax,293
        push ax
        mov ax,435
        push ax
        call PRINT_NUMBER

        
        


         mov ax,0x02
        push ax
        mov ax,stars
        push ax
        mov ax,83
        push ax
        mov ax,435
        push ax
        call PRINT_NUMBER
        mov ax,0x02
        push ax
        mov ax,stars
        push ax
        mov ax,153
        push ax
        mov ax,425
        push ax
        call PRINT_NUMBER
        mov ax,0x02
        push ax
        mov ax,stars
        push ax
        mov ax,223
        push ax
        mov ax,435
        push ax
        call PRINT_NUMBER
        mov ax,0x02
        push ax
        mov ax,stars
        push ax
        mov ax,293
        push ax
        mov ax,425
        push ax
        call PRINT_NUMBER

        
        pusha 
        
        mov cx,0x10
        great2:
        push cx
        mov cx,0xffff
        greater2:
            loop greater2
            pop cx
            loop great2    
            
        popa 

    delprev:
         mov ax,0x00
        push ax
        mov ax,stars
        push ax
        mov ax,83
        push ax
        mov ax,435
        push ax
        call PRINT_NUMBER
        mov ax,0x00
        push ax
        mov ax,stars
        push ax
        mov ax,153
        push ax
        mov ax,425
        push ax
        call PRINT_NUMBER
        mov ax,0x00
        push ax
        mov ax,stars
        push ax
        mov ax,223
        push ax
        mov ax,435
        push ax
        call PRINT_NUMBER
        mov ax,0x00
        push ax
        mov ax,stars
        push ax
        mov ax,293
        push ax
        mov ax,425
        push ax
        call PRINT_NUMBER

        dec cx
        cmp cx,0
        jne thebigone

    popa
    pop bp
    ret

    

;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; PRINT WORD(FUNCTION/SUBROUTINE)
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PRINT_WORD:       ;printing the word sukoku
push bp
mov bp,sp
push bx
PUSHA
mov ah,02h                      ;display
mov bh,00h          ;basically for placemnet of the cursor to a positions
mov dh,[bp+10]           ;row
mov dl,[bp+8]           ;column
int 10h             ;interrupt

mov cx,[bp+6]           ;length
mov si,0            ;displacement
OUTPUT:
mov bx,[bp+4]
mov ah,0Eh           ;teletyped output
mov al,[bx+si]
mov bh,00h
mov bl,[bp+12]
int 10h
inc si
loop OUTPUT
POPA
pop bx
pop bp
ret 10
;------------------------------------------------------;input movement
inputmovement:
    push bp
    mov bp,sp
    pusha
    mov ax,[bp+4]

    cmp ax,0
    je  up

    cmp ax,1
    je down

    cmp ax,2
    je left

    cmp ax,3
    je right

    jmp letters_and_numbers


    up:
          cmp word [inputrow],0
          jne cone

          
          mov ax,0x01
        push ax
        mov ax,[inputcol]
        mov bx,[initialinputcoordinatesrow]
        mul bx                        ;x-displacement
        add ax,37
        
        push ax

        mov ax,[inputrow]
        mov bx,[initialinputcoordinatescol]
        mul bx  
        add ax,37

        push ax
        mov ax,32     ;x-distance
        push ax
        mov ax,32     ;y-distance
        push ax
        call Draw_Rectangle


        mov word [inputrow],8

        mov ax,0x03
        push ax


        mov ax,[inputcol]
        mov bx,[initialinputcoordinatesrow]
        mul bx                        ;x-displacement
        add ax,37
        
        push ax

        mov ax,[inputrow]
        mov bx,[initialinputcoordinatescol]
        mul bx  
        add ax,37

        push ax
        mov ax,32    ;x-distance
        push ax
        mov ax,32     ;y-distance
        push ax
        call Draw_Rectangle  

        jmp exit


        cone:
        mov ax,0x01
        push ax


        mov ax,[inputcol]
        mov bx,[initialinputcoordinatesrow]
        mul bx                        ;x-displacement
        add ax,37
        
        push ax

        mov ax,[inputrow]
        mov bx,[initialinputcoordinatescol]
        mul bx  
        add ax,37

        push ax
        mov ax,32    ;x-distance
        push ax
        mov ax,32     ;y-distance
        push ax
        call Draw_Rectangle     


        dec word [inputrow]

        mov ax,0x03
        push ax


        mov ax,[inputcol]
        mov bx,[initialinputcoordinatesrow]
        mul bx                        ;x-displacement
        add ax,37
        
        push ax

        mov ax,[inputrow]
        mov bx,[initialinputcoordinatescol]
        mul bx  
        add ax,37

        push ax
        mov ax,32    ;x-distance
        push ax
        mov ax,32    ;y-distance
        push ax
        call Draw_Rectangle  

    jmp exit


    down:
        cmp word [inputrow],8
        jne cone1

          mov ax,0x01
        push ax
        mov ax,[inputcol]
        mov bx,[initialinputcoordinatesrow]
        mul bx                        ;x-displacement
        add ax,37
        
        push ax

        mov ax,[inputrow]
        mov bx,[initialinputcoordinatescol]
        mul bx  
        add ax,37

        push ax
        mov ax,32     ;x-distance
        push ax
        mov ax,32    ;y-distance
        push ax
        call Draw_Rectangle


        mov word [inputrow],0

        mov ax,0x03
        push ax


        mov ax,[inputcol]
        mov bx,[initialinputcoordinatesrow]
        mul bx                        ;x-displacement
        add ax,37
        
        push ax

        mov ax,[inputrow]
        mov bx,[initialinputcoordinatescol]
        mul bx  
        add ax,37

        push ax
        mov ax,32   ;x-distance
        push ax
        mov ax,32     ;y-distance
        push ax
        call Draw_Rectangle  

        jmp exit

        cone1:
        mov ax,0x01
        push ax


        mov ax,[inputcol]
        mov bx,[initialinputcoordinatesrow]
        mul bx                        ;x-displacement
        add ax,37
        
        push ax

        mov ax,[inputrow]
        mov bx,[initialinputcoordinatescol]
        mul bx  
        add ax,37

        push ax
        mov ax,32     ;x-distance
        push ax
        mov ax,32     ;y-distance
        push ax
        call Draw_Rectangle     


        inc word [inputrow]

        mov ax,0x03
        push ax


        mov ax,[inputcol]
        mov bx,[initialinputcoordinatesrow]
        mul bx                        ;x-displacement
        add ax,37
        
        push ax

        mov ax,[inputrow]
        mov bx,[initialinputcoordinatescol]
        mul bx  
        add ax,37

        push ax
        mov ax,32    ;x-distance
        push ax
        mov ax,32     ;y-distance
        push ax
        call Draw_Rectangle  

    jmp exit




    left:
        cmp word [inputcol],0
        jne cone3

          mov ax,0x01
        push ax
        mov ax,[inputcol]
        mov bx,[initialinputcoordinatesrow]
        mul bx                        ;x-displacement
        add ax,37
        
        push ax

        mov ax,[inputrow]
        mov bx,[initialinputcoordinatescol]
        mul bx  
        add ax,37

        push ax
        mov ax,32    ;x-distance
        push ax
        mov ax,32     ;y-distance
        push ax
        call Draw_Rectangle


        mov word [inputcol],8

        mov ax,0x03
        push ax


        mov ax,[inputcol]
        mov bx,[initialinputcoordinatesrow]
        mul bx                        ;x-displacement
        add ax,37
        
        push ax

        mov ax,[inputrow]
        mov bx,[initialinputcoordinatescol]
        mul bx  
        add ax,37

        push ax
        mov ax,32    ;x-distance
        push ax
        mov ax,32     ;y-distance
        push ax
        call Draw_Rectangle  

        jmp exit

        cone3:
        mov ax,0x01
        push ax


        mov ax,[inputcol]
        mov bx,[initialinputcoordinatesrow]
        mul bx                        ;x-displacement
        add ax,37
        
        push ax

        mov ax,[inputrow]
        mov bx,[initialinputcoordinatescol]
        mul bx  
        add ax,37

        push ax
        mov ax,32     ;x-distance
        push ax
        mov ax,32     ;y-distance
        push ax
        call Draw_Rectangle     


        dec word [inputcol]

        mov ax,0x03
        push ax


        mov ax,[inputcol]
        mov bx,[initialinputcoordinatesrow]
        mul bx                        ;x-displacement
        add ax,37
        
        push ax

        mov ax,[inputrow]
        mov bx,[initialinputcoordinatescol]
        mul bx  
        add ax,37

        push ax
        mov ax,32     ;x-distance
        push ax
        mov ax,32     ;y-distance
        push ax
        call Draw_Rectangle  

    jmp exit
    
    right:
        cmp word [inputcol],8
        jne cone4

         mov ax,0x01
        push ax
        mov ax,[inputcol]
        mov bx,[initialinputcoordinatesrow]
        mul bx                        ;x-displacement
        add ax,37
        
        push ax

        mov ax,[inputrow]
        mov bx,[initialinputcoordinatescol]
        mul bx  
        add ax,37

        push ax
        mov ax,32     ;x-distance
        push ax
        mov ax,32     ;y-distance
        push ax
        call Draw_Rectangle


        mov word [inputcol],0

        mov ax,0x03
        push ax


        mov ax,[inputcol]
        mov bx,[initialinputcoordinatesrow]
        mul bx                        ;x-displacement
        add ax,37
        
        push ax

        mov ax,[inputrow]
        mov bx,[initialinputcoordinatescol]
        mul bx  
        add ax,37

        push ax
        mov ax,32    ;x-distance
        push ax
        mov ax,32     ;y-distance
        push ax
        call Draw_Rectangle  

        jmp exit        


        cone4:
        mov ax,0x01
        push ax


        mov ax,[inputcol]
        mov bx,[initialinputcoordinatesrow]
        mul bx                        ;x-displacement
        add ax,37
        
        push ax

        mov ax,[inputrow]
        mov bx,[initialinputcoordinatescol]
        mul bx  
        add ax,37

        push ax
        mov ax,32     ;x-distance
        push ax
        mov ax,32     ;y-distance
        push ax
        call Draw_Rectangle     


        inc word [inputcol]

        mov ax,0x03
        push ax


        mov ax,[inputcol]
        mov bx,[initialinputcoordinatesrow]
        mul bx                        ;x-displacement
        add ax,37
        
        push ax

        mov ax,[inputrow]
        mov bx,[initialinputcoordinatescol]
        mul bx  
        add ax,37

        push ax
        mov ax,32     ;x-distance
        push ax
        mov ax,32     ;y-distance
        push ax
        call Draw_Rectangle  

    jmp exit


    letters_and_numbers:

        mov ah,0
        mov al,[inputcol]      ;calculation of index
        mov bl,9
        mul bl
        add al,[inputrow]
        mov si,ax
        mov ax,[bp+6]
        

         cmp al,0x02   ;1
         jne check2
         
        cmp word [pencil_var],0
        je normal1
        cmp byte [matrix + si],0
        jne exit
        ;print small 1
        jmp print1SmallInput

        normal1:
            call jobhi
         cmp byte [matrix + si],0
         jne exit

        push word [inputcol]
        push word [inputrow]
        call queue_position_insert

         cmp byte [dup_matrix + si], 1
         jne skip1
         mov byte [matrix + si], 1
         call correctinput
         add word [score],10
         call scoreprinter

         jmp print1Input
         skip1:
            jmp printWrongInput1


        check2:
         cmp al,0x03   ;2
         jne check3
         cmp word [pencil_var],0
        je normal2
        cmp byte [matrix + si],0
        jne exit
        ;print small 1
        jmp print2SmallInput

        normal2:
            call jobhi
         cmp byte [matrix + si],0
         jne exit
        push word [inputcol]
        push word [inputrow]
        call queue_position_insert
         cmp byte [dup_matrix + si], 2
         jne skip2
         mov byte [matrix + si], 2
                  call correctinput
         add word [score],10
         call scoreprinter
         jmp print2Input
         skip2:
            jmp printWrongInput2

         
        check3:
         cmp al,0x04   ;3
         jne check4
         cmp word [pencil_var],0
        je normal3
        cmp byte [matrix + si],0
        jne exit
        ;print small 1
        jmp print3SmallInput

        normal3:
            call jobhi
         cmp byte [matrix + si],0
         jne exit
          push word [inputcol]
        push word [inputrow]
        call queue_position_insert
         cmp byte [dup_matrix + si], 3
         jne skip3
         mov byte [matrix + si], 3
                  call correctinput

         add word [score],10
         call scoreprinter
         jmp print3Input
         skip3:
            jmp printWrongInput3

        
        check4:
            
         cmp al,0x05   ;4
         jne check5
         cmp word [pencil_var],0
        je normal4
        cmp byte [matrix + si],0
        jne exit
        ;print small 1
        jmp print4SmallInput

        normal4:
            call jobhi
         cmp byte [matrix + si],0
         jne exit
          push word [inputcol]
        push word [inputrow]
        call queue_position_insert
         cmp byte [dup_matrix + si], 4
         jne skip4
         mov byte [matrix + si], 4
                  call correctinput

         add word [score],10 
         call scoreprinter
         jmp print4Input
        skip4:
            jmp printWrongInput4

         
        check5:
         cmp al,0x06   ;5
         jne check6
         cmp word [pencil_var],0
        je normal5
        cmp byte [matrix + si],0
        jne exit
        ;print small 1
        jmp print5SmallInput

        normal5:
            call jobhi
         cmp byte [matrix + si],0
         jne exit
          push word [inputcol]
        push word [inputrow]
        call queue_position_insert
         cmp byte [dup_matrix + si], 5
         jne skip5
         mov byte [matrix + si], 5
                  call correctinput

         add word [score],10
         call scoreprinter
         jmp print5Input
        skip5:
            jmp printWrongInput5

    
        check6:
         cmp al,0x07   ;6
         jne check7
         cmp word [pencil_var],0
        je normal6
        cmp byte [matrix + si],0
        jne exit
        ;print small 1
        jmp print6SmallInput

        normal6:
            call jobhi
         cmp byte [matrix + si],0
         jne exit
          push word [inputcol]
        push word [inputrow]
        call queue_position_insert
         cmp byte [dup_matrix + si],6
         jne skip6
         mov byte [matrix + si], 6
                  call correctinput
         add word [score],10
         call scoreprinter
        jmp print6Input
         skip6:
            jmp printWrongInput6

         
        check7:
         cmp al,0x08   ;7
         jne check8
         cmp word [pencil_var],0
        je normal7
        cmp byte [matrix + si],0
        jne exit
        ;print small 1
        jmp print7SmallInput

        normal7:
            call jobhi
         cmp byte [matrix + si],0
         jne exit
          push word [inputcol]
        push word [inputrow]
        call queue_position_insert
         cmp byte [dup_matrix + si], 7
         jne skip7
         mov byte [matrix + si], 7
                  call correctinput
         add word [score],10
         call scoreprinter
         jmp print7Input
         skip7:
            jmp printWrongInput7

         
        check8:
         cmp al,0x09   ;8
         jne check9
         cmp word [pencil_var],0
        je normal8
        cmp byte [matrix + si],0
        jne exit
        ;print small 1
        jmp print8SmallInput

        normal8:
            call jobhi
         cmp byte [matrix + si],0
         jne exit
        push word [inputcol]
        push word [inputrow]
        call queue_position_insert
         cmp byte [dup_matrix + si], 8
         jne skip8
         mov byte [matrix + si], 8
             call correctinput
         add word [score],10
         call scoreprinter
        jmp print8Input
         skip8:
        jmp printWrongInput8

         
        check9:
         cmp al,0x0A   ;9
         jne checkdelete
         cmp word [pencil_var],0
        je normal9
        cmp byte [matrix + si],0
        jne exit
        ;print small 1
        jmp print9SmallInput

        normal9:
            call jobhi
         cmp byte [matrix + si],0
         jne exit
        push word [inputcol]
        push word [inputrow]
        call queue_position_insert
         cmp byte [dup_matrix + si], 9
         jne skip9
         mov byte [matrix + si], 9
        call correctinput
         add word [score],10
         call scoreprinter
         jmp print9Input
          skip9:
            jmp printWrongInput9

        checkdelete:
            cmp al, 0x53
            jne checkBackSpace
            cmp byte [matrix + si],0
            jne exit
            mov ax,0x01
            push ax
            mov ax,letter_clear
            push ax
            mov ax,[inputcol]
            mov bx,40
            mul bx
            add ax,46
            push ax
            mov ax,[inputrow]
            mov bx,40
            mul bx
            add ax,43
            push ax
            call PRINT_NUMBER
            call jobhi
            jmp exit


        print11SmallInput:

        mov ax,0x01
        push ax
        mov ax,letter_clear_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,39
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,39
        push ax
        call PRINT_NUMBER_SMALL
        jmp exit

        print22SmallInput:

        mov ax,0x01
        push ax
        mov ax,letter_clear_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,49
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,39
        push ax
        call PRINT_NUMBER_SMALL
        jmp exit

        print33SmallInput:

        mov ax,0x01
        push ax
        mov ax,letter_clear_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,59
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,39
        push ax
        call PRINT_NUMBER_SMALL
        jmp exit

        print44SmallInput:

        mov ax,0x01
        push ax
        mov ax,letter_clear_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,39
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,49
        push ax
        call PRINT_NUMBER_SMALL
        jmp exit

        print55SmallInput:

        mov ax,0x01
        push ax
        mov ax,letter_clear_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,49
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,49
        push ax
        call PRINT_NUMBER_SMALL
        jmp exit

        print66SmallInput:

        mov ax,0x01
        push ax
        mov ax,letter_clear_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,59
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,49
        push ax
        call PRINT_NUMBER_SMALL
        jmp exit

        print77SmallInput:

        mov ax,0x01
        push ax
        mov ax,letter_clear_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,39
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,59
        push ax
        call PRINT_NUMBER_SMALL
        jmp exit

        print88SmallInput:

        mov ax,0x01
        push ax
        mov ax,letter_clear_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,49
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,59
        push ax
        call PRINT_NUMBER_SMALL
        jmp exit

        print99SmallInput:

        mov ax,0x01
        push ax
        mov ax,letter_clear_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,59
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,59
        push ax
        call PRINT_NUMBER_SMALL
        
        jmp exit

        
        checkBackSpace:
            cmp al,0x0E
            jne checkpencil
            call undo_val
            jmp exit

        checkpencil:
            cmp al,0x19
            jne exit
            cmp word [pencil_var],0
            jne penciloff
            mov word [pencil_var],1

            mov ax,0x01
            push ax
            mov ax,506     ;x-displacement
            push ax
            mov ax,401        ;y-displacement
            push ax
            mov ax,36       ;x-distance
            push ax
            mov ax,36        ;y-distance
            push ax
            call DRAW_FILLED_RECTANGLE

            mov ax,0x00
            push ax
            mov ax,letter_pencil
            push ax
            mov ax,517
            push ax
            mov ax,410
            push ax
            call PRINT_NUMBER

            jmp exit
            penciloff:
            mov word [pencil_var],0

            mov ax,0x00
            push ax
            mov ax,506     ;x-displacement
            push ax
            mov ax,401        ;y-displacement
            push ax
            mov ax,36       ;x-distance
            push ax
            mov ax,36        ;y-distance
            push ax
            call DRAW_FILLED_RECTANGLE

            mov ax,0x02
            push ax
            mov ax,letter_pencil
            push ax
            mov ax,517
            push ax
            mov ax,410
            push ax
            call PRINT_NUMBER
                    
        
        jmp exit

        
        print1Input:
        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

        mov ax,0x03
        push ax
        mov ax,letter1
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER
        jmp checktoprintanim

        print2Input:
        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

        mov ax,0x03
        push ax
        mov ax,letter2
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER
        jmp checktoprintanim

        print3Input:
         mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

        mov ax,0x03
        push ax
        mov ax,letter3
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER
        jmp checktoprintanim

        print4Input:
        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

        mov ax,0x03
        push ax
        mov ax,letter4
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER
        jmp checktoprintanim

        print5Input:
        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

        mov ax,0x03
        push ax
        mov ax,letter5
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER
        jmp checktoprintanim

        print6Input:
        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

        mov ax,0x03
        push ax
        mov ax,letter6
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER
        jmp checktoprintanim

        print7Input:
        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

        mov ax,0x03
        push ax
        mov ax,letter7
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER
        jmp checktoprintanim

        print8Input:
        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

        mov ax,0x03
        push ax
        mov ax,letter8
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER
        jmp checktoprintanim

        print9Input:
        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

        mov ax,0x03
        push ax
        mov ax,letter9
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER
        jmp checktoprintanim


        printWrongInput1:
        inc word [mistakeslabel]
        push word [mistakeslabel]
        call mistake_print
        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER
        

        mov ax,0x0c
        push ax
        mov ax,letter1
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER


         pusha 
        
        mov cx,0x10
        great1:
        push cx
        mov cx,0xffff
        greater1:
            loop greater1
            pop cx
            loop great1       
            
        popa 


        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

        call wronginput
        cmp word [mistakeslabel], 3
        je jaguar
        jmp exit

        printWrongInput2:
        inc word[mistakeslabel]
        push word [mistakeslabel]
        call mistake_print
        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

        mov ax,0x0c
        push ax
        mov ax,letter2
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

          pusha 
        
        mov cx,0x10
        great3:
        push cx
        mov cx,0xffff
        greater3:
            loop greater3
            pop cx
            loop great3   
            
        popa 


        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER


        call wronginput
        cmp word [mistakeslabel], 3
        je jaguar
        jmp exit

        printWrongInput3:
        inc word[mistakeslabel]
        push word [mistakeslabel]
        call mistake_print
         mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

        mov ax,0x0c
        push ax
        mov ax,letter3
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER
        call wronginput

          pusha 
        
        mov cx,0x10
        great10:
        push cx
        mov cx,0xffff
        greater10:
            loop greater10
            pop cx
            loop great10    
            
        popa 


        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER


        cmp word [mistakeslabel], 3
        je jaguar
        jmp exit

        printWrongInput4:
        inc word[mistakeslabel]
        push word [mistakeslabel]
        call mistake_print
        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

        mov ax,0x0c
        push ax
        mov ax,letter4
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

          pusha 
        
        mov cx,0x10
        great4:
        push cx
        mov cx,0xffff
        greater4:
            loop greater4
            pop cx
            loop great4      
            
        popa 


        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER


        call wronginput
        cmp word [mistakeslabel], 3
        je jaguar
        jmp exit

        printWrongInput5:
        inc word[mistakeslabel]
        push word [mistakeslabel]
        call mistake_print
        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

        mov ax,0x0c
        push ax
        mov ax,letter5
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

          pusha 
        
        mov cx,0x10
        great5:
        push cx
        mov cx,0xffff
        greater5:
            loop greater5
            pop cx
            loop great5       
            
        popa 


        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER


        call wronginput
        cmp word [mistakeslabel], 3
        je jaguar
        jmp exit

        printWrongInput6:
        inc word[mistakeslabel]
        push word [mistakeslabel]
        call mistake_print
        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

        mov ax,0x0c
        push ax
        mov ax,letter6
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

          pusha 
        
        mov cx,0x10
        great6:
        push cx
        mov cx,0xffff
        greater6:
            loop greater6
            pop cx
            loop great6      
            
        popa 


        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER


        call wronginput
        cmp word [mistakeslabel], 3
        je jaguar
        jmp exit

        printWrongInput7:
        inc word[mistakeslabel]
        push word [mistakeslabel]
        call mistake_print
        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

        mov ax,0x0c
        push ax
        mov ax,letter7
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

          pusha 
        
        mov cx,0x10
        great7:
        push cx
        mov cx,0xffff
        greater7:
            loop greater7
            pop cx
            loop great7     
            
        popa 


        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER


        call wronginput
        cmp word [mistakeslabel], 3
        je jaguar
        jmp exit

        printWrongInput8:
        inc word[mistakeslabel]
        push word [mistakeslabel]
        call mistake_print
        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

        mov ax,0x0c
        push ax
        mov ax,letter8
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER
        call wronginput

          pusha 
        
        mov cx,0x10
        great8:
        push cx
        mov cx,0xffff
        greater8:
            loop greater8
            pop cx
            loop great8  
            
        popa 


        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER


        cmp word [mistakeslabel], 3
        je jaguar
        jmp exit

        printWrongInput9:
        inc word[mistakeslabel]
        push word [mistakeslabel]
        call mistake_print
        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER

        mov ax,0x0c
        push ax
        mov ax,letter9
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER
        call wronginput

          pusha 
        
        mov cx,0x10
        great9:
        push cx
        mov cx,0xffff
        greater9:
            loop greater9
            pop cx
            loop great9     
            
        popa 


        mov ax,0x01
        push ax
        mov ax,letter_clear
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,46
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,43
        push ax
        call PRINT_NUMBER
        call wronginput
        cmp word [mistakeslabel], 3
        je jaguar
        jmp exit

        print1SmallInput:

        mov ax,0x03
        push ax
        mov ax,letter1_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,39
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,39
        push ax
        call PRINT_NUMBER_SMALL
        jmp exit

        print2SmallInput:

        mov ax,0x03
        push ax
        mov ax,letter2_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,49
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,39
        push ax
        call PRINT_NUMBER_SMALL
        jmp exit

        print3SmallInput:

        mov ax,0x03
        push ax
        mov ax,letter3_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,59
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,39
        push ax
        call PRINT_NUMBER_SMALL
        jmp exit

        print4SmallInput:

        mov ax,0x03
        push ax
        mov ax,letter4_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,39
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,49
        push ax
        call PRINT_NUMBER_SMALL
        jmp exit

        print5SmallInput:

        mov ax,0x03
        push ax
        mov ax,letter5_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,49
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,49
        push ax
        call PRINT_NUMBER_SMALL
        jmp exit

        print6SmallInput:

        mov ax,0x03
        push ax
        mov ax,letter6_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,59
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,49
        push ax
        call PRINT_NUMBER_SMALL
        jmp exit

        print7SmallInput:

        mov ax,0x03
        push ax
        mov ax,letter7_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,39
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,59
        push ax
        call PRINT_NUMBER_SMALL
        jmp exit

        print8SmallInput:

        mov ax,0x03
        push ax
        mov ax,letter8_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,49
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,59
        push ax
        call PRINT_NUMBER_SMALL
        jmp exit

        print9SmallInput:

        mov ax,0x03
        push ax
        mov ax,letter9_small
        push ax
        mov ax,[inputcol]
        mov bx,40
        mul bx
        add ax,59
        push ax
        mov ax,[inputrow]
        mov bx,40
        mul bx
        add ax,59
        push ax
        call PRINT_NUMBER_SMALL
        jmp exit
        

    jaguar:
        in al,0x60
        cmp al,0x1c
        jne jaguar
        popcorn:
        cmp word [mistakeslabel],3
        jne skip13
        call losegamesound
        skip13:
        popa 
        pop bp
        pop ax
        pop ax
        pop ax
        mov al,0x20
        out 0x20,al
        pop ax
        pop ax
        pop ax
        jmp ending

        checktoprintanim:

        pusha
        push ax
        call checkrow
        pop ax
        cmp ax,1
        jne animcheck2
        call printanimation
        jmp dnc
        
        animcheck2:
            push ax
            call checkrcol
            pop ax
            cmp ax,1
            jne dnc
            call printanimation


        dnc:
        popa

    exit:
        push ax
        call endgamecondition
        pop ax
        cmp ax,1
        jne next12
        call wingamesound
        next12:
        cmp ax,1
        je popcorn
        popa
        pop bp
        ret 4

kbsir:
        mov ax,0xb800
        mov es,ax

        in al,0x60    
        


        cmp al,0x01
        jne next1                 ;escape if pressed undo the kbsir and returns to the end game screen
        mov word [inputcol],0
        mov word [inputrow],0
        call losegamesound
        mov al,0x20
        out 0x20,al
        pop ax
        pop ax
        pop ax
        je ending


        next1:       ;up
        cmp al,0x48
        jne nextkey
                        push ax
         mov word [direction],0
         push word [direction]
        call inputmovement
        jmp nomatch


        nextkey:
        cmp al,0x50      ;down
        jne nextkey1
                        push ax
                mov word [direction],1
                 push word [direction]
         call inputmovement
        jmp nomatch


        nextkey1:
        cmp al,0x4B        ;left
        jne nextkey2
                        push ax
                mov word [direction],2
                 push word [direction]
         call inputmovement
        jmp nomatch



        nextkey2:         ;right
        cmp al,0x4D
        jne nextkey3
        push ax
        mov word [direction],3
        push word [direction]
         call inputmovement
         jmp nomatch


          nextkey3:                          ; 1-9 A,P,backspace
                push ax
                 mov word [direction],4
                push word [direction]
         call inputmovement

         
        

        nomatch:
        mov al,0x20
        out 0x20,al
        iret

;mistake printer
mistake_printend:
    push bp
    mov bp,sp
    pusha

    mov ax,[bp+4]

    cmp ax,0
    je zero00
    cmp ax,1
    je one11
    cmp ax,2
    je two22
    cmp ax,3
    je three33
    jmp returerr


    zero00:
    mov al,0x02
    push ax
    mov ax,12
    push ax
    mov ax,34
    push ax
    mov ax,[length13]
    push ax
    mov ax,message13
    push ax
    call PRINT_WORD 
    jmp returerr    

    one11:
    mov al,0x02
    push ax
    mov ax,12
    push ax
    mov ax,34
    push ax
    mov ax,[length20]
    push ax
    mov ax,message20
    push ax
    call PRINT_WORD 
    jmp returerr


    two22:
    mov al,0x02
    push ax
    mov ax,12
    push ax
    mov ax,34
    push ax
    mov ax,[length21]
    push ax
    mov ax,message21
    push ax
    call PRINT_WORD 
    jmp returerr

    three33:
    mov al,0x02
    push ax
    mov ax,12
    push ax
    mov ax,34
    push ax
    mov ax,[length22]
    push ax
    mov ax,message22
    push ax
    call PRINT_WORD 
    jmp returerr


    returerr:
    popa
    pop bp
    ret 2

mistake_print:
    push bp
    mov bp,sp
    pusha

    mov ax,[bp+4]

    cmp ax,1
    je one1
    cmp ax,2
    je two2
    cmp ax,3
    je three3
    jmp returer

    one1:
    mov al,0x02
    push ax
    mov ax,1
    push ax
    mov ax,5
    push ax
    mov ax,[length20]
    push ax
    mov ax,message20
    push ax
    call PRINT_WORD 
    jmp returer


    two2:
    mov al,0x02
    push ax
    mov ax,1
    push ax
    mov ax,5
    push ax
    mov ax,[length21]
    push ax
    mov ax,message21
    push ax
    call PRINT_WORD 
    jmp returer

    three3:
    mov al,0x02
    push ax
    mov ax,1
    push ax
    mov ax,5
    push ax
    mov ax,[length22]
    push ax
    mov ax,message22
    push ax
    call PRINT_WORD 
    jmp returer


    returer:
    popa
    pop bp
    ret 2


;ending function check (win)

endgamecondition:
    push bp
    mov bp,sp

    PUSHA

    mov cx,81
    mov si,0

    mov ax,1
    mov [bp+4],ax

    loopers:
        cmp byte [matrix+si],0
        jne skipped
        mov ax,0
        mov [bp+4],ax
        skipped:
            inc si
            loop loopers

    popa
    pop bp
    ret

;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; DRAW RECTANGLE(FUNCTION/SUBROUTINE)
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Draw_Rectangle:
push bp
mov bp,sp
PUSHA
mov ah,0x0C             ;for pixel draw
mov al,[bp+12]            ;light red colored
mov bh,0x00             ;page number

mov cx,[bp+10]          ;x
mov dx,[bp+8]           ;y
mov di,[bp+6]          ;x
mov si,[bp+4]          ;y
add di,[bp+10]
add si,[bp+8]
add di,1
add si,1

loop:         ;x-line
int 10h
inc dx
cmp dx,si
jne loop

mov dx,[bp+8]           

loopx:         ;y-line
int 10h
inc cx
cmp cx,di
jne loopx

mov dx,[bp+8]
add dx,[bp+4]
mov cx,[bp+10]
add cx,[bp+6]
mov si,[bp+8]
mov di,[bp+10]
sub si,1
sub di,1

loop3:
int 10h
dec dx
cmp dx,si
jne loop3

mov dx,[bp+8]
add dx,[bp+4]

loop4:
int 10h
dec cx
cmp cx,di
jne loop4

POPA
pop bp

ret 10

makeallzero:
    push bp
    mov bp,sp

    mov si,0
    mov di,0

    looping:
        push si
        mov ax,si
        mov bx,9
        mul bl
        mov si,ax
        add si,di
        mov bx,[bp+4]
        mov ax,di
        add ax,1
        mov byte [bx+si],al
        pop si
        inc di
        cmp di,9
        jne looping


    mov bx,[bp+4]
    mov si,1
    mov di,0


    loopie1:
        push si
        mov ax,si
        mov bx,9
        mul bl
        mov si,ax
        add si,di
        mov bx,[bp+4]
        mov byte [bx+si],0

        pop si
        inc di
        cmp di,9
        jne loopie1
        mov di,0
        inc si
        cmp si,9
        jne loopie1

        pop bp
        ret 2

DRAW_FILLED_RECTANGLE:

    ; mov ax,0x01
    ; push ax
    ; mov ax,450     ;x-displacement
    ; push ax
    ; mov ax,110        ;y-displacement
    ; push ax
    ; mov ax,5       ;x-distance
    ; push ax
    ; mov ax,5        ;y-distance
    ; push ax
    ; call DRAW_FILLED_RECTANGLE
    push bp
    mov bp,sp

    mov si,[bp+6]      ;x
    mov di,[bp+4]      ;y

    mov cx,[bp+10]     ;x
    mov dx,[bp+8]     ;y

    add si,cx
    add di,dx
    
    looper:
    ;draw
    pusha 
    mov ah,0x0C
    mov al,[bp+12]
    mov bh,0x00
    int 10h
    popa
    inc cx
    cmp cx,si
    jne looper
    mov cx,[bp+10]
    inc dx
    cmp dx,di
    jne looper
    

    pop bp
    ret 10
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;design loading screen (SUDOKU BITMAP)
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PRINT_NUMBER_BIT:
push bp
mov bp,sp
sub sp,2


mov bx,[bp+8] ;address
mov cx,[bp+6] ;x
mov dx,[bp+4] ;y

mov di,8
mov si,0
mov ax,32
mov [bp-2],ax

    draw_mode2:
        cmp si,8160
        je exiting2
        mov ax,0
        mov al,[bx+si]
        mov di,8

    looped2:
        shl al,1
        jnc nope2

        PUSHA
        mov ah,0x0C
        mov al,[bp+10]
        mov bh,0x00
        int 10h
        POPA

    nope2:
        inc cx
        dec di
        cmp di,0
        jne looped2
    
        inc si

        push ax
        mov ax,[bp-2]
        dec ax
        mov [bp-2],ax
        cmp ax,0

        jne continuing2

        inc dx
        mov cx,[bp+6]
        mov ax,32
        mov [bp-2],ax
    
    continuing2:
        pop ax
        jmp draw_mode2

        


exiting2:
    add sp,2
    pop bp
    ret 8

;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ;PRINT NUMBER(large)
 ;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PRINT_NUMBER:
push bp
mov bp,sp
pusha
sub sp,2


mov bx,[bp+8] ;address
mov cx,[bp+6] ;x
mov dx,[bp+4] ;y

mov di,8
mov si,0
mov ax,2
mov [bp-2],ax

    draw_mode:
        cmp si,32
        je exiting
        mov ax,0
        mov al,[bx+si]
        mov di,8

    looped:
        shl al,1
        jnc nope

        PUSHA
        mov ah,0x0C
        mov al,[bp+10]
        mov bh,0x00
        int 10h
        POPA

    nope:
        inc cx
        dec di
        cmp di,0
        jne looped
    
        inc si

        push ax
        mov ax,[bp-2]
        dec ax
        mov [bp-2],ax
        cmp ax,0

        jne continuing

        inc dx
        mov cx,[bp+6]
        mov ax,2
        mov [bp-2],ax
    
    continuing:
        pop ax
        jmp draw_mode


exiting:
    add sp,2
    popa
    pop bp
    ret 8
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;SMALL NUMBERS
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PRINT_NUMBER_SMALL:
push bp
mov bp,sp

mov bx,[bp+8] ;address
mov cx,[bp+6] ;x
mov dx,[bp+4] ;y

mov di,8
mov si,0

    draw_mode1:
        cmp si,8
        je exiting1
        mov ax,0
        mov al,[bx+si]
        mov di,8
    looped1:
        shl al,1
        jnc nope1

        PUSHA
        mov ah,0x0C
        mov al,[bp+10]
        mov bh,0x00
        int 10h
        POPA

    nope1:
        inc cx
        dec di
        cmp di,0
        jne looped1
    
        inc si
        mov di,8
        inc dx
        mov cx,[bp+6]
        jmp draw_mode1


exiting1:
    pop bp
    ret 8

GENERATE_RANDOM_NUMBER:
    push bp
    mov bp,sp
pusha 

rdtsc          
shl dx, 32    
or ax, dx    
mov [seed], ax

mov ax, [seed]
add ax, 7    
mov [seed], ax

xor dx, dx
mov cx, 9     
div cx       
add dl, 1   
; mov [matrix], dl  ;where to store value
mov [bp+4],dl

popa
pop bp
ret 


GENERATE_RANDOM_NUMBER81:
    push bp
    mov bp,sp
pusha 

rdtsc          
shl dx, 32    
or ax, dx    
mov [seed], ax

mov ax, [seed]
add ax, 7    
mov [seed], ax

xor dx, dx
mov cx, 81     
div cx       
add dl, 1   
; mov [matrix], dl  ;where to store value
mov [bp+4],dl

popa
pop bp
ret 

;-----------------------------------------------------------first row swap (part of backtracking)--------------------------------------------
random_swap_row:

    mov cx,9
    mov bx,matrix
    l12:
        push cx
        xor ax,ax
        push ax
        call GENERATE_RANDOM_NUMBER
        pop ax
        sub ax,1
        mov si,ax            ;index1

        xor ax,ax
        push ax
        call GENERATE_RANDOM_NUMBER
        pop ax
        sub ax,1
        mov di,ax             ;index2

        mov al,[bx+di]
        xchg byte [bx+si],al
        mov [bx+di],al
        pop cx
        loop l12

        ret 2
;-------------------------------------------------------------------------------------------validity check-------------------------------------------------
valid:
    push bp
    mov bp,sp
    sub sp,4
    PUSHA

;           push ax        ;12(extra)
;           push cx      ;10(number)
;           push si      ;8(row)
;           push di      ;6(col)
;           push matrix  ;4(matrix)
;           call valid   ;2

    mov cx,[bp+10] ;number
    mov si,[bp+8]   ;row
    mov di,[bp+6]   ;col
    mov bx,[bp+4]    ;matrix

    mov dx,0
    row_and_col_check:
        push di
        
         push dx
         push bx

        mov ax,dx
        mov bx,9
        mul bx
        mov dx,ax

        pop bx

        add di,dx
        pop dx
        cmp [bx+di],cl           ;[i][col]==number?->false
        je popping

        pop di
        push si
        push bx
        mov ax,si
        mov bx,9
        push dx
        mul bx
        pop dx
        mov si,ax
        pop bx
        add si,dx
        cmp [bx+si],cl             ;[row][i]==number?->false
        je popping2
        pop si

        inc dx               ;loop condition
        cmp dx,[sizeboard]
        jne row_and_col_check


        nextcheck:
        mov cx,[bp+10] ;number
        mov si,[bp+8]   ;row
        mov di,[bp+6]   ;col
        mov bx,[bp+4]    ;matrix

        A3x3check:
        mov ax,si          ;row/3*3
        mov bx,3
        div bl          ;row/3
        mul bl          ;row/3*3
        mov si,ax       ;->new row (3x3 grid one)

        mov ax,di
        div bl              ;col/3
        mul bl              ;col/3*3
        mov di,ax          ;->new col    (3x3 grid one)


        mov ax,3             ;row (end point check)
        add ax,si
        mov [bp-2],ax         ;row+3

        mov ax,3             ;col (end point check)
        add ax,di
        mov [bp-4],ax       ;col+3


        outerloop:
          push si
          mov ax,si
          mov bx,9
          mul bx
          mov si,ax
          add si,di       ;row+Col
          mov bx,[bp+4]    ;matrix

          cmp [bx+si],cl        ;matrix[row][col]=number
          je popping2
          pop si

          inc di
          cmp [bp-4],di
          jne outerloop

          mov di,[bp+6]
          mov ax,di
          mov bx,3
          div bl              ;col/3
          mul bl              ;col/3*3
          mov di,ax          ;->new col    (3x3 grid one)

          inc si
          cmp [bp-2],si
          jne outerloop  
        

        mov ax,1
        mov [bp+12],ax
        popa
        add sp,4
        pop bp
        ret 8

    popping:
        pop di
        jmp returning_false

    popping2:
        pop si
        
    returning_false:
        mov ax,0
        mov [bp+12],ax
        popa
        add sp,4
        pop bp
        ret 8

;-------------------------------------------------------------------(SODUKO SOLVER)-------------------------------------

matrix_solver:

    push bp
    mov bp,sp
    pusha 

PUSHA
 

mov al, 0x00
mov dx, 0x3c8
out dx, al
mov dx, 0x3c9


; Grid (#01200F)
mov al, 0
out dx, al
mov al, 8
out dx, al
mov al, 4
out dx, al

; Numbers (#9EC5AB)
mov al, 40
out dx, al
mov al, 49
out dx, al
mov al, 43
out dx, al

; Strings (#52938C)
mov al, 63
out dx, al
mov al, 63
out dx, al
mov al, 63
out dx, al

; Background (#104F55)
mov al, 4
out dx, al
mov al, 20
out dx, al
mov al, 21
out dx, al

PUSHA
mov al,0x02
push ax
mov ax,13                ;printing difficulty modes
push ax
mov ax,37
push ax
mov ax,[length19]
push ax
mov ax,message19
push ax
 call PRINT_WORD
 POPA

 POPA



    mov si,[bp+8]  ;row
    mov di,[bp+6]   ;col
    mov bx,[bp+4]    ;matrix

    basecase:
        mov ax,[sizeboard]           
        dec ax
        cmp word si,ax          ;row==baordsize-1
        jne end_of_row
        inc ax
        cmp word di,ax        ;col==boardsize
        jne end_of_row
        ;ret
        mov ax,1
        mov [bp+10],ax
        popa 
        pop bp
        ret 6

    end_of_row:
        mov ax,[sizeboard]         ;if col==sizeboard
        cmp di,ax
        jne nullspace 
        inc si                ;row++ 
        mov di,0           ;col=0

    nullspace:
        push si
        mov ax,si
        mov bx,9
        mul bx
        mov si,ax
        add si,di
        mov bx,[bp+4]    ;matrix
        cmp byte [bx+si],0          ;if matrix[i][j]!=0
        je  loop_to_check          ;call function recursive and return its value

        pop si
        inc di

        push ax              ;10
        push si              ;8
        push di             ;6          
        push matrix           ;4
        call matrix_solver    ;2
        pop ax               ;pop the value 1/0 returned and return done

        
        mov [bp+10],ax
        popa
        dec di
        pop bp
        ret 6
    

    loop_to_check:
    pop si

    mov cx,1
    looper1:
        push cx

          push ax        ;12(extra)
          push cx      ;10(number)
          push si      ;8(row)
          push di      ;6(col)
          push matrix  ;4(matrix)
          call valid   ;2

          pop ax
          cmp ax,1
          jne reloop

          push si
          mov ax,si
          mov bx,9
          mul bx
          mov si,ax
          add si,di       ;row+Col
          mov bx,[bp+4]    ;matrix
          mov [bx+si],cl        ;matrix[row][col]=number
          pop si

            recursive:                
                inc di
                push ax              ;10
                push si              ;8
                push di             ;6          
                push matrix           ;4
                call matrix_solver    ;2
                pop ax               ;pop the value 1/0 returned and return done
                dec di
                cmp ax,1
                jne move_zero

                mov ax,1
                mov [bp+10],ax
                pop cx
                popa
                pop bp
                ret 6                

            move_zero:
                 push si
                 mov ax,si
                 mov bx,9
                 mul bx
                 mov si,ax
                 add si,di
                 mov bx,[bp+4]    ;matrix
                 mov byte [bx+si],0        ;matrix[row][col]=number
                 pop si

            reloop:
            pop cx
            inc cx
            mov ax,[sizeboard]
            add ax,1
            cmp cx,ax
            jne looper1

            mov ax,0
            mov [bp+10],ax
            popa
            pop bp
            ret 6
;---------------------------------------------------------------------------------------------------
remove_n_indices:
    push bp
    mov bp,sp

    mov cx,[bp+6] ;no to remove
    mov bx,[bp+4] ;matrix
    mov dx,0

removing:
    xor ax,ax
    push ax
    call GENERATE_RANDOM_NUMBER81       
    pop ax
    sub ax,1
    mov si,ax            ;index1
          ;index1

    push si
    cmp byte [bx+si],0
    jne swap
    pop si
    jmp removing
    swap:
    mov bx,[bp+4]
    mov byte [bx+si],0
    pop si
    loop removing

    pop bp
    ret 4

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;SCREEN_IMPLEMENT SCREEN_IMPLEMENT SCREEN_IMPLEMENT SCREEN_IMPLEMENTSCREEN_IMPLEMENT SCREEN_IMPLEMENT SCREEN_IMPLEMENT SCREEN_IMPLEMENT SCREEN_IMPLEMENT SCREEN_IMPLEMENT SCREEN_IMPLEMENT SCREEN_IMPLEMENT SCREEN_IMPLEMENT SCREEN_IMPLEMENT SCREEN_IMPLEMENT SCREEN_IMPLEMENT
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;LOAD SCREEN (SUBROUTINE)
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
LOADSCREEN_TRANSITION:
mov ah,0x00             ;to set the video mode.
mov al,0x12  
int 10h

mov al, 0x00
mov dx, 0x3c8
out dx, al
mov dx, 0x3c9


; Grid (#01200F)
mov al, 0
out dx, al
mov al, 8
out dx, al
mov al, 4
out dx, al

; Numbers (#9EC5AB)
mov al, 40
out dx, al
mov al, 49
out dx, al
mov al, 43
out dx, al

; Strings (#52938C)
mov al, 63
out dx, al
mov al, 63
out dx, al
mov al, 63
out dx, al

; Background (#104F55)
mov al, 4
out dx, al
mov al, 20
out dx, al
mov al, 21
out dx, al





mov dx,639
mov si,479
mov di,0
mov bx,0
mov cx,10
border:
    mov ax,0x02
    push ax
    mov ax,di      ;x-displacement
    push ax
    mov ax,bx         ;y-displacement
    push ax
    mov ax,dx       ;x-distance
    push ax
    mov ax,si       ;y-distance
    push ax
    call Draw_Rectangle 
sub dx,2
sub si,2
inc di
inc bx
loop border


PUSHA                    ;printing sukoku bitmap
mov ax,0x02
push ax
mov ax,biggg
push ax
mov ax,200
push ax
mov ax,80
push ax
call PRINT_NUMBER_BIT
POPA


PUSHA                     ;printing the word press any key to continue
mov ax,0x02
push ax
mov ax,22                             
push ax
mov ax,27            
push ax
mov ax,[length1]
push ax
mov ax,message1
push ax
 call PRINT_WORD             
 POPA

ret
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;PLAY OPTION SCREEN (SUBROUTINE)
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PLAY_OPTION_SCREEN:
mov ah,0x00             ;to set the video mode.
mov al,0x12  
int 10h

mov al, 0x00
mov dx, 0x3c8
out dx, al
mov dx, 0x3c9


; Grid (#01200F)
mov al, 0
out dx, al
mov al, 8
out dx, al
mov al, 4
out dx, al

; Numbers (#9EC5AB)
mov al, 40
out dx, al
mov al, 49
out dx, al
mov al, 43
out dx, al

; Strings (#52938C)
mov al, 63
out dx, al
mov al, 63
out dx, al
mov al, 63
out dx, al

; Background (#104F55)
mov al, 4
out dx, al
mov al, 20
out dx, al
mov al, 21
out dx, al

PUSHA
mov al,0x02
push ax
mov ax,5                 ;printing difficulty modes
push ax
mov ax,28
push ax
mov ax,[length2]
push ax
mov ax,message2
push ax
 call PRINT_WORD
 POPA

 PUSHA
 mov al,0x01
push ax
mov ax,10                ;printing difficulty modes
push ax
mov ax,34
push ax
mov ax,[length3]
push ax
mov ax,message3
push ax
 call PRINT_WORD            
 POPA

 PUSHA
 mov al,0x01
push ax
mov ax,12               ;printing difficulty modes
push ax
mov ax,34
push ax
mov ax,[length4]
push ax
mov ax,message4
push ax
 call PRINT_WORD             
 POPA

 PUSHA
 mov al,0x01
push ax
mov ax,14              ;printing difficulty modes
push ax
mov ax,34
push ax
mov ax,[length5]
push ax
mov ax,message5
push ax
 call PRINT_WORD             
 POPA

  PUSHA
  mov al,0x03
push ax
mov ax,16             ;printing EXIT
push ax
mov ax,34
push ax
mov ax,[length6]
push ax
mov ax,message6
push ax
 call PRINT_WORD
 POPA

inf:
 mov ax,0x00
 int 16h

one:
 cmp al,'1'
 jne two
 mov bx,1
 mov [difficulty_index],bx

pusha
    mov ah,0x00             ;to set the video mode.
    mov al,0x12  
    int 10h
popa

    push matrix
    call random_swap_row

    push ax              ;10
    push word [row]              ;8
    push word [col]              ;6
    push matrix           ;4
    call matrix_solver    ;2
    pop ax

    call copy_inother

     mov ax,2
     push ax
     push matrix
     call remove_n_indices




 jmp rete

two:
 cmp al,'2'
  jne three
 mov bx,2
 mov [difficulty_index],bx

pusha
    mov ah,0x00             ;to set the video mode.
    mov al,0x12  
    int 10h
popa

push matrix
    call random_swap_row

    push ax              ;10
    push word [row]              ;8
    push word [col]              ;6
    push matrix           ;4
    call matrix_solver    ;2
    pop ax
        call copy_inother



     mov ax,35
     push ax
     push matrix
     call remove_n_indices




jmp rete

 three:
cmp al,'3'
jne four
 mov bx,3
 mov [difficulty_index],bx

pusha
    mov ah,0x00             ;to set the video mode.
    mov al,0x12  
    int 10h
popa

push matrix
    call random_swap_row

    push ax              ;10
    push word [row]              ;8
    push word [col]              ;6
    push matrix           ;4
    call matrix_solver    ;2
    pop ax
        call copy_inother


     mov ax,45
     push ax
     push matrix
     call remove_n_indices
 


 jmp rete

 four:
cmp al,'4'
jne inf

mov ax,0x4c00
int 21h

rete:
ret
 ;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ;DRAWING GRID (SUBROUTINE)
 ;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DRAW_GRID_GAME:

mov ah,0x00             ;to set the video mode.
mov al,0x12  
int 10h

mov al, 0x00
mov dx, 0x3c8
out dx, al
mov dx, 0x3c9

; Grid (#01200F)
mov al, 0
out dx, al
mov al, 8
out dx, al
mov al, 4
out dx, al

; Numbers (#9EC5AB)
mov al, 40
out dx, al
mov al, 49
out dx, al
mov al, 43
out dx, al

; Strings (#52938C)
mov al, 63
out dx, al
mov al, 63
out dx, al
mov al, 63
out dx, al

; Background (#104F55)
mov al, 4
out dx, al
mov al, 20
out dx, al
mov al, 21
out dx, al







mov word [minutes],0
mov word [second],0
mov word [ticks],0
mov word [time],0

    mov ax,0x01
    push ax
    mov ax,33      ;x-displacement
    push ax
    mov ax,33        ;y-displacement
    push ax
    mov ax,360      ;x-distance
    push ax
    mov ax,360        ;y-distance
    push ax
    call DRAW_FILLED_RECTANGLE


mov bp,sp
sub sp,4


mov si,0
mov cx,33      ;column(x)
mov dx,33      ;row(y)

basic:
mov ah,0x0C    ;code for pixel draw
mov al,0x03    ;color for grid
mov bh,0x00

mov word [bp-2],3

mov cx,33
mov dx,33
mov word [bp-2],10

mov word [bp-4],1
mov di,1

grid1:                    ;grid vertical
mov dx,33
mov cx,33
add cx,si
next:
int 10h
inc dx
cmp dx,393
jne next

dec word [bp-4]
cmp word [bp-4],0
jne continue

mov dx,33
inc cx
loopy:
int 10h
inc dx
cmp dx,390
jne loopy

mov dx,33
inc cx
loop1:
int 10h
inc dx
cmp dx,393
jne loop1

mov word [bp-4],3

continue:
mov cx,33
mov dx,33

grid2:               ;grid horizontal
add dx,si
next2:
int 10h
inc cx
cmp cx,394
jne next2

dec di
cmp di,0
jne continue2

mov cx,33
inc dx
loope:
int 10h
inc cx
cmp cx,394
jne loope

mov cx,33
inc dx
loop2:
int 10h
inc cx
cmp cx,393
jne loop2

mov di,3


continue2:
dec word [bp-2]
cmp word [bp-2],0
je BOXES
add si,40
mov cx,33
mov dx,33
jmp grid1
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;Drawing nodes and boxes (rectangles)
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
BOXES:
    ;SCOREBOARD
    mov ax,0x01
    push ax
    mov ax,447     ;x-displacement
    push ax
    mov ax,107        ;y-displacement
    push ax
    mov ax,157       ;x-distance
    push ax
    mov ax,57        ;y-distance
    push ax
    call DRAW_FILLED_RECTANGLE
        
    mov ax,0x03
    push ax
    mov ax,450       ;x-displacement
    push ax
    mov ax,110         ;y-displacement
    push ax
    mov ax,150        ;x-distance
    push ax
    mov ax,50        ;y-distance
    push ax
    call Draw_Rectangle           

;TIMER
    mov ax,0x03
    push ax
    mov ax,472      ;x-displacement
    push ax
    mov ax,35         ;y-displacement
    push ax
    mov ax,110        ;x-distance
    push ax
    mov ax,40        ;y-distance
    push ax
    call Draw_Rectangle           

;NODES 1ST ROW
mov si,0
mov di,3
BUTTONS1:
    mov ax,0x03
    push ax
    mov ax,450       ;x-displacement
    add ax,si
    push ax
    mov ax,190         ;y-displacement
    push ax
    mov ax,37        ;x-distance
    push ax
    mov ax,37        ;y-distance
    push ax
    call Draw_Rectangle
add si,57
dec di
jnz BUTTONS1


;NODES 2ND ROW
mov si,0
mov di,3
BUTTONS2:

    mov ax,0x03
    push ax
    mov ax,450       ;x-displacement
    add ax,si
    push ax
    mov ax,260         ;y-displacement
    push ax
    mov ax,37        ;x-distance
    push ax
    mov ax,37        ;y-distance
    push ax
    call Draw_Rectangle

add si,57
dec di
jnz BUTTONS2

;NODES 3RD ROW
mov si,0
mov di,3
BUTTONS3:

    mov ax,0x03
    push ax
    mov ax,450       ;x-displacement
    add ax,si
    push ax
    mov ax,330      ;y-displacement
    push ax
    mov ax,37        ;x-distance
    push ax
    mov ax,37        ;y-distance
    push ax
    call Draw_Rectangle
add si,57
dec di
jnz BUTTONS3

;PENCIL BUTTON
mov ax,0x03
    push ax
    mov ax,505       ;x-displacement
    push ax
    mov ax,400      ;y-displacement
    push ax
    mov ax,37        ;x-distance
    push ax
    mov ax,37        ;y-distance
    push ax
    call Draw_Rectangle

;UNDO BUTTON
mov ax,0x03
    push ax
    mov ax,450       ;x-displacement
    push ax
    mov ax,400      ;y-displacement
    push ax
    mov ax,37        ;x-distance
    push ax
    mov ax,37        ;y-distance
    push ax
    call Draw_Rectangle

;ERASE BUTTON
mov ax,0x03
    push ax
    mov ax,563       ;x-displacement
    push ax
    mov ax,400      ;y-displacement
    push ax
    mov ax,37        ;x-distance
    push ax
    mov ax,37        ;y-distance
    push ax
    call Draw_Rectangle

;ANIMATION BOARD

mov ax,0x03
    push ax
    mov ax,50       ;x-displacement
    push ax
    mov ax,415      ;y-displacement
    push ax
    mov ax,300        ;x-distance
    push ax
    mov ax,50        ;y-distance
    push ax
    call Draw_Rectangle


;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;TEXTS ON GAME SCREEN
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;DIFFICULTY TEXT
mov al,0x02
push ax
mov ax,1
push ax
mov ax,43
push ax

mov bx,1
cmp [difficulty_index],bx
jne med
mov ax,[length12]
push ax
mov ax,message12
push ax
jmp calling

med:
mov bx,2
cmp [difficulty_index],bx
jne hard
mov ax,[length17]
push ax
mov ax,message17
push ax
jmp calling

hard:
mov bx,3
cmp [difficulty_index],bx
mov ax,[length18]
push ax
mov ax,message18
push ax

calling:
 call PRINT_WORD 

 ;MISTAKES TEXT
mov al,0x02
push ax
mov ax,1
push ax
mov ax,5
push ax
mov ax,[length13]
push ax
mov ax,message13
push ax
 call PRINT_WORD 

;SCOREBOARD TEXT
mov ax,0x00
push ax
mov ax,letterS
push ax
mov ax,455
push ax
mov ax,125
push ax
call PRINT_NUMBER

mov ax,0x00
push ax
mov ax,letterC
push ax
mov ax,467
push ax
mov ax,125
push ax
call PRINT_NUMBER

mov ax,0x00
push ax
mov ax,letterO
push ax
mov ax,480
push ax
mov ax,125
push ax
call PRINT_NUMBER

mov ax,0x00
push ax
mov ax,letterR
push ax
mov ax,495
push ax
mov ax,125
push ax
call PRINT_NUMBER

mov ax,0x00
push ax
mov ax,letterE
push ax
mov ax,509
push ax
mov ax,125
push ax
call PRINT_NUMBER

    call scoreprinter

mov ax,0x02
push ax
mov ax,letter_pencil
push ax
mov ax,517
push ax
mov ax,410
push ax
call PRINT_NUMBER

;UNDO BUTTON TEXT
mov ax,0x02
push ax
mov ax,letter_undo
push ax
mov ax,461
push ax
mov ax,410
push ax
call PRINT_NUMBER

;ERASE BUTTON TEXT
mov ax,0x02
push ax
mov ax,letter_erase
push ax
mov ax,575
push ax
mov ax,410
push ax
call PRINT_NUMBER



;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;print numbers(notes)
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;GRID NUMBERS
;---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PUSHA

readArr: 
mov si,matrix
mov di, 43 ; x start
mov bx, 46 ; y start
mov cx, 9 ; counter
;------------------------------------------------------------------------------------------------------
aloop1:
call aloop2 
add bx, 40
loop aloop1
jmp endMatrix
aloop2:
push cx
mov cx, 9
mov di, 43
aloop3:
mov dl, [si]
cmp dl, 1 
je print1
cmp dl, 2 
je print2
cmp dl, 3 
je print3
cmp dl, 4 
je print4
cmp dl, 5 
je print5
cmp dl, 6 
je print6
cmp dl, 7 
je print7
cmp dl, 8 
je print8
cmp dl, 9 
je print9
endpmat: 
inc si
add di, 40
loop aloop3
pop cx 
ret
;---------------------------------------------------------------------------------------------------------
print1:
mov ax,0x00
push ax
mov ax,letter1
push ax
mov ax,bx
push ax
mov ax,di
push ax
call PRINT_NUMBER
jmp endpmat

print2:
mov ax,0x00
push ax
mov ax,letter2
push ax
mov ax,bx
push ax
mov ax,di
push ax
call PRINT_NUMBER
jmp endpmat
print3:
mov ax,0x00
push ax
mov ax,letter3
push ax
mov ax,bx
push ax
mov ax,di
push ax
call PRINT_NUMBER
jmp endpmat

print4:
mov ax,0x00
push ax
mov ax,letter4
push ax
mov ax,bx
push ax
mov ax,di
push ax
call PRINT_NUMBER
jmp endpmat
print5:
mov ax,0x00
push ax
mov ax,letter5
push ax
mov ax,bx
push ax
mov ax,di
push ax
call PRINT_NUMBER
jmp endpmat

print6:
mov ax,0x00
push ax
mov ax,letter6
push ax
mov ax,bx
push ax
mov ax,di
push ax
call PRINT_NUMBER
jmp endpmat
print7:
mov ax,0x00
push ax
mov ax,letter7
push ax
mov ax,bx
push ax
mov ax,di
push ax
call PRINT_NUMBER
jmp endpmat

print8:
mov ax,0x00
push ax
mov ax,letter8
push ax
mov ax,bx
push ax
mov ax,di
push ax
call PRINT_NUMBER
jmp endpmat
print9:
mov ax,0x00
push ax
mov ax,letter9
push ax
mov ax,bx
push ax
mov ax,di
push ax
call PRINT_NUMBER
jmp endpmat
;------------------------------------------------------------------------------------------------------------
endMatrix:
POPA

drawinputbox:
mov ax,0x03
    push ax
    mov ax,37      ;x-displacement
    push ax
    mov ax,37      ;y-displacement
    push ax
    mov ax,32     ;x-distance
    push ax
    mov ax,32    ;y-distance
    push ax
    call Draw_Rectangle
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;NODES NUMBERS
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; mov ax,0x00
; push ax
; mov ax,letter1_small
; push ax
; mov ax,79
; push ax
; mov ax,39
; push ax
; call PRINT_NUMBER_SMALL

; mov ax,0x00
; push ax
; mov ax,letter2_small
; push ax
; mov ax,49
; push ax
; mov ax,39
; push ax
; call PRINT_NUMBER_SMALL

; mov ax,0x00
; push ax
; mov ax,letter3_small
; push ax
; mov ax,59
; push ax
; mov ax,39
; push ax
; call PRINT_NUMBER_SMALL

; mov ax,0x00
; push ax
; mov ax,letter4_small
; push ax
; mov ax,39
; push ax
; mov ax,49
; push ax
; call PRINT_NUMBER_SMALL

; mov ax,0x00
; push ax
; mov ax,letter5_small
; push ax
; mov ax,49
; push ax
; mov ax,49
; push ax
; call PRINT_NUMBER_SMALL

; mov ax,0x00
; push ax
; mov ax,letter6_small
; push ax
; mov ax,59
; push ax
; mov ax,49
; push ax
; call PRINT_NUMBER_SMALL

; mov ax,0x00
; push ax
; mov ax,letter7_small
; push ax
; mov ax,39
; push ax
; mov ax,59
; push ax
; call PRINT_NUMBER_SMALL

; mov ax,0x00
; push ax
; mov ax,letter8_small
; push ax
; mov ax,49
; push ax
; mov ax,59
; push ax
; call PRINT_NUMBER_SMALL

; mov ax,0x00
; push ax
; mov ax,letter9_small
; push ax
; mov ax,59
; push ax
; mov ax,59
; push ax
; call PRINT_NUMBER_SMALL

;row1
mov bx,0
mov si,0
mov cx,3
print_loop_nodes:
PUSHA
mov ax,0x02
push ax
mov ax,letter1
add ax,si
push ax
mov ax,460
add ax,bx
push ax
mov ax,201
push ax
call PRINT_NUMBER
POPA
add si,32
add bx,58
loop print_loop_nodes
;row2
mov bx,0
mov si,0
mov cx,3
print_loop_nodes2:
PUSHA
mov ax,0x02
push ax
mov ax,letter4
add ax,si
push ax
mov ax,460
add ax,bx
push ax
mov ax,270
push ax
call PRINT_NUMBER
POPA
add si,32
add bx,58
loop print_loop_nodes2
;row3
mov bx,0
mov si,0
mov cx,3
print_loop_nodes3:
PUSHA
mov ax,0x02
push ax
mov ax,letter7
add ax,si
push ax
mov ax,460
add ax,bx
push ax
mov ax,340
push ax
call PRINT_NUMBER
POPA
add si,32
add bx,58
loop print_loop_nodes3

call wingamesound

pusha

xor ax,ax
mov es,ax

cli
mov ax,[es:8*4]
mov [timer_old],ax
mov ax,[es:8*4+2]
mov [timer_old+2],ax


mov word [es:8*4],timer
mov [es:8*4+2],cs

mov ax,[es:9*4]
mov [key_old],ax
mov ax,[es:9*4+2]
mov [key_old+2],ax

mov word [es:9*4],kbsir
mov [es:9*4+2],cs
sti

popa





add sp,4
ret

;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ;End game screen
;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ending:

push matrix
 call makeallzero

mov ah,0x00             ;to set the video mode.
mov al,0x12  
int 10h

mov al, 0x00
mov dx, 0x3c8
out dx, al
mov dx, 0x3c9


; Grid (#01200F)
mov al, 0
out dx, al
mov al, 8
out dx, al
mov al, 4
out dx, al

; Numbers (#9EC5AB)
mov al, 40
out dx, al
mov al, 49
out dx, al
mov al, 43
out dx, al

; Strings (#52938C)
mov al, 63
out dx, al
mov al, 63
out dx, al
mov al, 63
out dx, al

; Background (#104F55)
mov al, 4
out dx, al
mov al, 20
out dx, al
mov al, 21
out dx, al


pusha 

xor ax,ax
mov  es,ax

mov ax,[timer_old]
mov [es:8*4],ax
mov ax,[timer_old+2]
mov [es:8*4+2],ax

mov ax,[key_old]
mov [es:9*4],ax
mov ax,[key_old+2]
mov [es:9*4+2],ax

popa

PUSHA
mov ax,cs                        ;TIMER TIME PRINT AT END OF GAME
mov es,ax
mov ax,0

mov al,0x00
mov ah,13h
mov bh,0x00
mov bl,0x02            ;color
mov cx,5
mov dh,14
mov dl,43
mov bp,time
int 10h
POPA


    mov ax,0x03
    push ax
    mov ax,220     ;x-displacement
    push ax
    mov ax,105        ;y-displacement
    push ax
    mov ax,200       ;x-distance
    push ax
    mov ax,50        ;y-distance
    push ax
    call DRAW_FILLED_RECTANGLE


 cmp word [mistakeslabel],3
    je lossprint

    PUSHA
    mov ax,0x02
    push ax
    mov ax,letterY
    push ax
    mov ax,250
    push ax
    mov ax,120
    push ax
    call PRINT_NUMBER
    POPA

    PUSHA
    mov ax,0x02
    push ax
    mov ax,letterO
    push ax
    mov ax,270
    push ax
    mov ax,120
    push ax
    call PRINT_NUMBER
    POPA

    PUSHA
    mov ax,0x02
    push ax
    mov ax,letterU
    push ax
    mov ax,290
    push ax
    mov ax,120
    push ax
    call PRINT_NUMBER
    POPA

    PUSHA
    mov ax,0x02
    push ax
    mov ax,letterW
    push ax
    mov ax,330
    push ax
    mov ax,120
    push ax
    call PRINT_NUMBER
    POPA

    PUSHA
    mov ax,0x02
    push ax
    mov ax,letterI
    push ax
    mov ax,350
    push ax
    mov ax,120
    push ax
    call PRINT_NUMBER
    POPA

    PUSHA
    mov ax,0x02
    push ax
    mov ax,letterN
    push ax
    mov ax,370
    push ax
    mov ax,120
    push ax
    call PRINT_NUMBER
    POPA
    jmp  conter



lossprint:
PUSHA
mov ax,0x02
push ax
mov ax,letterG
push ax
mov ax,240
push ax
mov ax,120
push ax
call PRINT_NUMBER
POPA

PUSHA
mov ax,0x02
push ax
mov ax,letterA
push ax
mov ax,260
push ax
mov ax,120
push ax
call PRINT_NUMBER
POPA

PUSHA
mov ax,0x02
push ax
mov ax,letterM
push ax
mov ax,280
push ax
mov ax,120
push ax
call PRINT_NUMBER
POPA

PUSHA
mov ax,0x02
push ax
mov ax,letterE
push ax
mov ax,300
push ax
mov ax,120
push ax
call PRINT_NUMBER
POPA

PUSHA
mov ax,0x02
push ax
mov ax,letterO
push ax
mov ax,320
push ax
mov ax,120
push ax
call PRINT_NUMBER
POPA

PUSHA
mov ax,0x02
push ax
mov ax,letterV
push ax
mov ax,340
push ax
mov ax,120
push ax
call PRINT_NUMBER
POPA

PUSHA
mov ax,0x02
push ax
mov ax,letterE
push ax
mov ax,360
push ax
mov ax,120
push ax
call PRINT_NUMBER
POPA

PUSHA
mov ax,0x02
push ax
mov ax,letterR
push ax
mov ax,380
push ax
mov ax,120
push ax
call PRINT_NUMBER
POPA


conter:
PUSHA 
mov cx,10
mov bx,0
mov dx,0
rects:
    mov ax,0x03
    push ax
    mov ax,140       ;x-displacement
    add ax,dx
    push ax
    mov ax,80         ;y-displacement
    add ax,dx
    push ax
    mov ax,350        ;x-distance
    sub ax,bx
    push ax
    mov ax,320        ;y-distance
    sub ax,bx
    push ax
    call Draw_Rectangle  
    inc dx
    add bx,2
    loop rects
POPA

;MISTAKES

push word [mistakeslabel]
call mistake_printend

;NEW GAME
mov ax,0x03
push ax
mov ax,175     ;x-displacement
push ax
mov ax,290         ;y-displacement
push ax
mov ax,100        ;x-distance
push ax
mov ax,40        ;y-distance
push ax
call Draw_Rectangle  

;END GAME
mov ax,0x03
push ax
mov ax,355       ;x-displacement
push ax
mov ax,290         ;y-displacement
push ax
mov ax,100        ;x-distance
push ax
mov ax,40        ;y-distance
push ax
call Draw_Rectangle 


;TIMER
 PUSHA
mov ax,0x02
push ax
mov ax,14
push ax
mov ax,34
push ax
mov ax,[length7]
push ax
mov ax,message7
push ax
call PRINT_WORD             
POPA

 
;NEW GAME TEXT
PUSHA
mov ax,0x02
push ax
mov ax,19
push ax
mov ax,24
push ax
mov ax,[length15]
push ax
mov ax,message15
push ax
 call PRINT_WORD             
 POPA

;END GAME TEXT
 PUSHA
mov ax,0x02
push ax
mov ax,19
push ax
mov ax,46
push ax
mov ax,[length16]
push ax
mov ax,message16
push ax
 call PRINT_WORD             
 POPA
 
  mov word [mistakeslabel],0
  mov word [pushes],0
 mov word [inputcol],0
 mov word [inputrow],0
  mov word [undo_queue_col],0  
  mov word [undo_queue_col+2],0  
  mov word [undo_queue_col+4],0  
  mov word [undo_queue_row],0  
  mov word [undo_queue_row+2],0  
  mov word [undo_queue_row+4],0  
  mov word [score],0



 ret
 ;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ;MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN-MAIN
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
MAIN_GAME:
PUSHA 
call LOADSCREEN_TRANSITION                      ;to draw loading screen
POPA

mov ah,0x00             ;press any key to continue
int 16h

PLAY_OPTION:
PUSHA 
call PLAY_OPTION_SCREEN                     ;to draw option menu
POPA

PUSHA 
call DRAW_GRID_GAME                ;to draw grid and nodes
POPA

l7:
    jmp l1
   PUSHA 
   call ending
   POPA

   l1:
   mov ax,0x00             ;press any key to continue
   int 16h

   cmp al,0x1B
   je END_OF_GAME
   cmp al,0x0D
   je PLAY_OPTION
  jmp l1

    
END_OF_GAME:
mov ax,0x4c00
int 21h


;-------------------------------------------------------------------------------------------------------------------------------------
