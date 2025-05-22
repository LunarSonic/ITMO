ORG 0x0DA
T1: WORD 0x0 ; тест 1 для проверки ADCSP без выставления флага C
T2: WORD 0x0 ; тест 2 для проверки ADCSP, в котором V=0 и C=1
T3: WORD 0x0 ; тест 3 для проверки ADCSP, в котором V=1 и C=1
T4: WORD 0x0 ; тест 4 для проверки ADCSP, сравниваем сложение 2 чисел без флага C и +1
             ; со сложением 2 чисел, где C=1

ORG 0x0E6
START: CALL $TEST1 ; вызываем 1 тест
       LD $T1
       HLT
       CALL $TEST2 ; вызываем 2 тест
       LD $T2
       HLT
       CALL $TEST3 ; вызываем 3 тест
       LD $T3
       HLT
       CALL $TEST4 ; вызываем 4 тест
       LD $T4
       HLT

ORG 0x100
X1: WORD 0x0112
Y1: WORD 0x0014
RES1: WORD 0x0126
TEST1: LD X1
       PUSH
       LD Y1
       PUSH
       WORD 0x0F10  ; команда ADCSP
       HLT
       POP          ; снять со стека результат команды
       CMP RES1     ; сравнить его с RES1
       BNE ERROR1
       POP          ; снять со стека 2 число
       POP          ; снять со стека 1 число
       LD #0x01     ; записать 1 при корректном результате
       ST $T1
       RET
ERROR1: POP         ; снять со стека 2 число
        POP         ; снять со стека 1 число
        LD #0x00
        ST $T1      ; записать 0 при некорректном результате
        RET

ORG 0x150
X2: WORD 0xFDDD
Y2: WORD 0x4022
RES2: WORD 0x3E00
TEST2: LD X2
       PUSH
       LD Y2
       PUSH
       WORD 0x0F10 ; команда ADCSP
       HLT
       POP         ; снять со стека результат команды
       CMP RES2    ; сравнить его с RES2
       BNE ERROR2
       POP         ; снять со стека 2 число
       POP         ; снять со стека 1 число
       LD #0x01    ; записать 1 при корректном результате
       ST $T2
       RET
ERROR2: POP         ; снять со стека 2 число
        POP         ; снять со стека 1 число
        LD #0x00
        ST $T2      ; записать 0 при некорректном результате
        RET

ORG 0x200
X3: WORD 0xC087
Y3: WORD 0xA074
RES3: WORD 0x60FC
TEST3: LD X3
       PUSH
       LD Y3
       PUSH
       WORD 0x0F10 ; команда ADCSP
       HLT
       POP         ; снять со стека результат команды
       CMP RES3    ; сравнить его с RES3
       BNE ERROR3
       POP         ; снять со стека 2 число
       POP         ; снять со стека 1 число
       LD #0x01
       ST $T3      ; записать 1 при корректном результате
       RET
ERROR3: POP        ; снять со стека 2 число
        POP        ; снять со стека 1 число
        LD #0x00
        ST $T3     ; записать 0 при некорректном результате
        RET

ORG 0x250
X4: WORD 0x3013
Y4: WORD 0x3F7A
RES4: WORD 0x0
TEST4: CLC         ; C=0
       LD X4
       PUSH
       LD Y4
       PUSH
       WORD 0x0F10 ; команда ADCSP
       HLT
       POP         ; снять со стека результат сложения 2 чисел
       INC         ; инкрементирование результата на 1
       ST $RES4    ; положить в RES4, чтобы потом сравнить со 2 результатом
       POP         ; снять со стека 2 число
       POP         ; снять со стека 1 число
       CLC         ; С=0
       CMC         ; инвертирование флага C (C=1)
       HLT
       LD X4
       PUSH
       LD Y4
       PUSH
       WORD 0x0F10 ; команда ADCSP
       HLT
       POP         ; снять со стека результат команды
       CMP RES4    ; сравнить его с RES4
       BNE ERROR4
       POP         ; снять со стека 2 число
       POP         ; снять со стека 1 число
       LD #0x01
       ST $T4      ; записать 1 при корректном результате
       RET
ERROR4: POP        ; снять со стека 2 число
        POP        ; снять со стека 1 число
        LD #0x00
        ST $T4     ; записать 0 при некорректном результате
        RET















