[org 0x0100]

mov bx,0
mov  bl,[starting_bit_number] ;bx=15
mov si,0 ;cx=0
mov dx,8 ;dx=8

call divide_By_Eight

cmp bx,0 ;compare remainder with 0
jnz case1 ;remainder is not 0 i.e starting_bit_number is not a multiple of 8.
jz  case2 ;remainderis 0 i.e starting_bit_number is multiple of 8



 case1: ;incase starting_bit_number is not a multiple of 8.
 
      mov dh,[buffer+si];mov the qoutient'th byte in dh
      mov dl,[buffer+si+1];and the byte next to qoutient'th byte in dl
      mov cx,bx

        l2: ;shift dx left remainder so that required bits are shifted in dh.
          shl dx,1 
          sub cx,1
          jnz l2

     mov bx,0
     mov bl,dh ;move hihger bits of dh in bl which are basically the required answer
     mov ax,bx
	 
jmp terminate

case2: ;incase starting_bit_number is a multiple of 8.

       mov dx,0
       mov dl,[buffer+si] ;mov the qoutient'th byte in dl
       mov ax,dx ;move dl in ax which are basically the required answer
	   
jmp terminate

divide_By_Eight: ;division by repeated subtraction

                 l1:
                    sub bx,dx ;subtract bx(starting_bit_number) by dx(8)
                    add si,1 ;si will contain the quotient and is incremented at each jump
                    cmp bx,dx ;compare current value of bx register with dx(8)
                 jge l1 ;jump will be taken till bx is greater then or equal to dx(8).
				 
ret                     ;at the end bx will contain the remainder and si will contain qoutient


terminate:
           mov ax,0x4c00
           int 0x21

buffer: db 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32
starting_bit_number: db 15