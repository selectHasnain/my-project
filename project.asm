.MODEL SMALL
.STACK 100H
.DATA
; -------- UI DESIGN --------
welcome DB 10,13,'===============================$'
        DB 10,13,' QUIZ GAME SYSTEM (ASM) $'
        DB 10,13,'===============================$'
menu DB 10,13,'1. Start Quiz'
     DB 10,13,'2. Exit'
     DB 10,13,'Enter Choice: $'
newline DB 10,13,'$'
; -------- QUESTIONS --------
Q1 DB 10,13,'Q1: Capital of Pakistan?$'
Q1A DB 10,13,'1) Karachi 2) Lahore'
    DB 10,13,'3) Islamabad 4) Quetta $'
Q2 DB 10,13,'Q2: 10 / 2 = ?$'
Q2A DB 10,13,'1) 2 2) 5 3) 10 4) 8 $'
Q3 DB 10,13,'Q3: Sun rises from?$'
Q3A DB 10,13,'1) West 2) East 3) North 4) South $'
; -------- MESSAGES --------
correctMsg DB 10,13,'Correct Answer! $'
wrongMsg DB 10,13,'Wrong Answer! $'
finalMsg DB 10,13,'Your Final Score: $'
excellent DB 10,13,'Performance: Excellent! $'
good DB 10,13,'Performance: Good! $'
poor DB 10,13,'Performance: Poor! $'
retryMsg DB 10,13,'Play Again? (Y/N): $'
score DB 0
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
START:
    MOV score, 0
; -------- WELCOME --------
    MOV AH, 09H
    LEA DX, welcome
    INT 21H
    LEA DX, menu
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    CMP AL, 1
    JE QUIZ_START
    JMP EXIT
; -------- QUIZ START --------
QUIZ_START:
; ----- Q1 -----
    MOV AH, 09H
    LEA DX, Q1
    INT 21H
    LEA DX, Q1A
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    CMP AL, 3
    JE C1
    JMP W1
C1:
    INC score
    MOV AH, 09H
    LEA DX, correctMsg
    INT 21H
    JMP Q2_START
W1:
    MOV AH, 09H
    LEA DX, wrongMsg
    INT 21H
; ----- Q2 -----
Q2_START:
    MOV AH, 09H
    LEA DX, Q2
    INT 21H
    LEA DX, Q2A
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    CMP AL, 2
    JE C2
    JMP W2
C2:
    INC score
    MOV AH, 09H
    LEA DX, correctMsg
    INT 21H
    JMP Q3_START
W2:
    MOV AH, 09H
    LEA DX, wrongMsg
    INT 21H
; ----- Q3 -----
Q3_START:
    MOV AH, 09H
    LEA DX, Q3
    INT 21H
    LEA DX, Q3A
    INT 21H
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    CMP AL, 2
    JE C3
    JMP W3
C3:
    INC score
    MOV AH, 09H
    LEA DX, correctMsg
    INT 21H
    JMP RESULT
W3:
    MOV AH, 09H
    LEA DX, wrongMsg
    INT 21H
; -------- RESULT --------
RESULT:
    MOV AH, 09H
    LEA DX, finalMsg
    INT 21H
    MOV AL, score
    ADD AL, 30H
    MOV DL, AL
    MOV AH, 02H
    INT 21H
; ----- PERFORMANCE -----
    CMP score, 3
    JE SHOW_EXCELLENT
    CMP score, 2
    JE SHOW_GOOD
    JMP SHOW_POOR
SHOW_EXCELLENT:
    MOV AH, 09H
    LEA DX, excellent
    INT 21H
    JMP RETRY
SHOW_GOOD:
    MOV AH, 09H
    LEA DX, good
    INT 21H
    JMP RETRY
SHOW_POOR:
    MOV AH, 09H
    LEA DX, poor
    INT 21H
; -------- RETRY --------
RETRY:
    MOV AH, 09H
    LEA DX, retryMsg
    INT 21H
    MOV AH, 01H
    INT 21H
    CMP AL, 'Y'
    JE START
    CMP AL, 'y'
    JE START
EXIT:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN