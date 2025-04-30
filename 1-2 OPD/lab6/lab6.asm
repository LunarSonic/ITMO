ORG 0x0                 ; происходит инициализация векторов прерывания
V0: WORD $DEFAULT, 0x180
V1: WORD $INT1   , 0x180
V2: WORD $DEFAULT, 0x180
V3: WORD $INT3   , 0x180
V4: WORD $DEFAULT, 0x180
V5: WORD $DEFAULT, 0x180
V6: WORD $DEFAULT, 0x180
V7: WORD $DEFAULT, 0x180

DEFAULT: IRET          ; обработка прерывания по умолчанию

ORG 0x16
X: WORD ?
MIN: WORD 0xFFD7       ; -41, min значение X
MAX: WORD 0x002B       ;  43, max значение X

ORG 0x20
START: DI              ; запрет прерываний для ВУ, которые не используются
       CLA
       OUT 0x1         ; MR КВУ-0 на вектор 0
       OUT 0x5         ; MR КВУ-2 на вектор 0
       OUT 0xB         ; MR КВУ-4 на вектор 0
       OUT 0xD         ; MR КВУ-5 на вектор 0
       OUT 0x11        ; MR КВУ-6 на вектор 0
       OUT 0x15        ; MR КВУ-7 на вектор 0
       OUT 0x19        ; MR КВУ-8 на вектор 0
       OUT 0x1D        ; MR КВУ-9 на вектор 0
       LD #0x9         ; разрешение прерывания и вектор #1
       OUT 0x3         ; (1000|0001) = 1001 в MR КВУ-1
       LD #0xB         ; разрешение прерывания и вектор #3
       OUT 0x7         ; (1000|0111) = 1011 в MR КВУ-3
       EI              ; разрешаем прерывание

; основная программа
ORG 0x30
MAIN:  LD X
       INC
       INC
       CALL CHECK      ; проверяем, находится ли значение AC в пределах ОДЗ
       ST X
       JUMP MAIN

; проверка X на соответствие ОДЗ
ORG 0x40
CHECK: CMP $MIN
       BLT LD_MIN
       CMP $MAX
       BEQ RETURN
       BGE LD_MIN
       JUMP RETURN
LD_MIN: LD $MIN
RETURN: RET

; обработка прерывания на ВУ-1
ORG 0x50
INT1:  LD X
       CALL CHECK       ; проверяем, находится ли значение AC в пределах ОДЗ
       PUSH             ; сохранили AC
       ST X
       NOP              ; отладочная точка останова
       ASL              ; 2X
       ASL              ; 4X
       SUB X            ; 3X
       NEG              ; -3X
       ADD #0x03        ; -3X+3
       OUT 0x2          ; запись из AC по адресу в DR КВУ-1
       NOP              ; отладочная точка останова
       POP              ; вернули AC назад
       EI
       IRET

; обработка прерывания на ВУ-3
ORG 0x60
INT3:  LD X
       CALL CHECK       ; проверяем, находится ли значение AC в пределах ОДЗ
       PUSH             ; сохранили AC
       ST X
       CLA
       IN 0x6
       NOP              ; отладочная точка останова
       SUB X
       CALL CHECK       ; проверяем, находится ли значение AC в пределах ОДЗ
       ST X
       NOP              ; отладочная точка останова
       POP              ; вернули AC назад
       EI
       IRET