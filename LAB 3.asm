;mov ax,1234h
;mov bl,0ah

;mov ax,bx  
;mov cx,1235h
;mov dx,cx    
;mov [2000h],ax
;mov al,5        ; incremate
;inc al   

;mov al,4
;dec al ;decreamate

;mov ah,1            ;take value from
;int 21h
;mov ah,2         ;display value
;mov dl,'A'
;int 21h     
;Swap two value
mov ax,1234h
mov bx,5678h
xchg ax,bx