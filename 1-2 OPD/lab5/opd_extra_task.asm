ORG 0x60
ADDR: WORD $DATA ; ячейка с адресом ячейки данных, которые мы вводим с помощью ВУ-9
TEMP: WORD ? ; переменная для работы с 1 цфирой дня
TOTAL: WORD ? ; сумма (день + код месяца + код года), потом уменьшаем её на 7, чтобы получить остаток
REMAINDER: WORD ? ; остаток (TOTAL mod7)
COUNTER: WORD 0x05 ; счётчик для 5 символов (учитывая точку)

; значения для рассчёта дня недели по формуле (день + код месяца + код года) mod7
; например, 19.03 (19+2+3) = 24, 24mod7 = 3 - среда
; 0 - воскресенье, 1 - понедельник и т.д
MONTH_CODE: WORD ? ; код месяца, который будет устанавливаться при проверке месяца
YEAR_CODE: WORD 0x03
MARCH_CODE: WORD 0x02
APRIL_CODE: WORD 0x05

START: IN 0x1D
       AND #0x40
       BEQ START
       IN 0x1C
       ST (ADDR)+
       LOOP COUNTER
       JUMP START

; проверка первой цифры месяца (она равна 0)
LD 0x03
CMP #0x00
BNE PRINT_ERROR

; проверка второй цифры месяца
LD 0x04
CMP #0x03
BEQ CHECK_MARCH
CMP #0x04
BEQ CHECK_APRIL
BNE PRINT_ERROR         ; ошибка, если это не март и не апрель

; проверяем дату, если это март
CHECK_MARCH:
    LD MARCH_CODE
    ST MONTH_CODE       ; устанавливаем код месяца (для марта - 02)
    ; проверяем день для марта
    LD 0x00             ; первая цифра дня
    CMP #0x01           ; если она равна 1
    BEQ CHECK_MARCH_1   ; то переходим к проверке 2 цифры дня

    CMP #0x02           ; если она равна 2
    BEQ CHECK_MARCH_2   ; то переходим к проверке 2 цифры дня

    CMP #0x03 ; если она равна 3
    BEQ CHECK_MARCH_3 ; то переходим к проверке 2 цифры дня
    JUMP PRINT_ERROR ; иначе ошибка

    CHECK_MARCH_1:
         LD 0x01
         CMP #0x09      ; если вторая цифра равна 9
         BNE PRINT_ERROR
         JUMP CHECK_POINT

    CHECK_MARCH_2:
         LD 0x01
         CMP #0x0A      ; если вторая цифра от 0 до 9
         BGE PRINT_ERROR
         JUMP CHECK_POINT

    CHECK_MARCH_3:
        LD 0x01
        CMP #0x02
        BGE PRINT_ERROR
        JUMP CHECK_POINT

; проверяем дату, если это апрель
CHECK_APRIL:
    LD APRIL_CODE
    ST MONTH_CODE      ; устанавливаем код месяца (для апреля - 05)
    ; день для апреля может быть только 01 и 02
    LD 0x00
    CMP #0x00          ; если первая цифра равна 0
    BNE PRINT_ERROR
    LD 0x01
    CMP #0x01
    BEQ CHECK_POINT
    CMP #0x02
    BEQ CHECK_POINT
    JUMP PRINT_ERROR

; проверка на точку (3 символ)
CHECK_POINT:
    LD 0x02
    CMP #0xE
    BNE PRINT_ERROR
    JUMP CALCULATE_TOTAL

; вычисление TOTAL = (день + код месяца + код года)
CALCULATE_TOTAL:
    LD 0x00
    ST TEMP
    ADD TEMP
    ADD TEMP
    ADD TEMP
    ADD TEMP
    ADD TEMP
    ADD TEMP
    ADD TEMP
    ADD TEMP
    ADD TEMP         ; умножение на 10
    ADD 0x01         ; (TEMP*10 + 2 цифра дня)
    ADD MONTH_CODE
    ADD YEAR_CODE
    ST TOTAL

; вычисление дня недели (TOTAL mod7)
MOD_LOOP:
    LD TOTAL
    SUB #7           ; вычитаем 7 из AC
    BLT MOD_FINISHED ; если результат < 7, выходим из цикла
    ST TOTAL         ; иначе сохраняем новое значение в TOTAL (чтобы дальше отнимать 7 и в итоге получить остаток)
    ST REMAINDER     ; устанвливаем остаток
    JUMP MOD_LOOP

MOD_FINISHED:
    LD REMAINDER     ; загружаем остаток в AC
    CMP #00
    BEQ PRINT_SUNDAY
    CMP #01
    BEQ PRINT_MONDAY
    CMP #02
    BEQ PRINT_TUESDAY
    CMP #03
    BEQ PRINT_WEDNESDAY
    CMP #04
    BEQ PRINT_THURSDAY
    CMP #05
    BEQ PRINT_FRIDAY
    CMP #06
    BEQ PRINT_SATURDAY

FINISH: HLT

PRINT_ERROR: PUSH
             CALL $ERROR
             POP
             JUMP FINISH

PRINT_MONDAY: PUSH
              CALL $MONDAY
              POP
              JUMP FINISH

PRINT_TUESDAY: PUSH
               CALL $TUESDAY
               POP
               JUMP FINISH

PRINT_WEDNESDAY: PUSH
                 CALL $WEDNESDAY
                 POP
                 JUMP FINISH

PRINT_THURSDAY:  PUSH
                 CALL $THURSDAY
                 POP
                 JUMP FINISH

PRINT_FRIDAY:    PUSH
                 CALL $FRIDAY
                 POP
                 JUMP FINISH

PRINT_SATURDAY:  PUSH
                 CALL $SATURDAY
                 POP
                 JUMP FINISH

PRINT_SUNDAY:    PUSH
                 CALL $SUNDAY
                 POP
                 JUMP FINISH
                 
ORG 0x150
ERROR: LD #0x18 ; буква о
       OUT 0x10
       LD #0x24
       OUT 0x10
       LD #0x18
       OUT 0x10
       LD #0x00
       OUT 0x10

       LD #0x3C ; буква ш
       OUT 0x10
       LD #0x04
       OUT 0x10
       LD #0x3C
       OUT 0x10
       LD #0x04
       OUT 0x10
       LD #0x3C
       OUT 0x10
       LD #0x00
       OUT 0x10

       LD #0x3C ; буква и
       OUT 0x10
       LD #0x08
       OUT 0x10
       LD #0x10
       OUT 0x10
       LD #0x3C
       OUT 0x10
       LD #0x00
       OUT 0x10

       LD #0x3C ; буква б
       OUT 0x10
       LD #0x2C
       OUT 0x10
       LD #0x2C
       OUT 0x10
       LD #0x00
       OUT 0x10

       LD #0x3C ; буква к
       OUT 0x10
       LD #0x18
       OUT 0x10
       LD #0x24
       OUT 0x10
       LD #0x00
       OUT 0x10

       LD #0x1C ; буква а
       OUT 0x10
       LD #0x28
       OUT 0x10
       LD #0x1C
       OUT 0x10
       LD #0x00
       OUT 0x10
       LD #0x00
       OUT 0x10
       RET

ORG 0x190
MONDAY: LD #0x3C ; буква п
        OUT 0x10
        LD #0x20
        OUT 0x10
        LD #0x3C
        OUT 0x10
        LD #0x00
        OUT 0x10

        LD #0x18 ; буква о
        OUT 0x10
        LD #0x24
        OUT 0x10
        LD #0x18
        OUT 0x10
        LD #0x00
        OUT 0x10

        LD #0x3C ; буква н
        OUT 0x10
        LD #0x10
        OUT 0x10
        LD #0x3C
        OUT 0x10
        LD #0x00
        OUT 0x10

        LD #0x38 ; буква e
        OUT 0x10
        LD #0x2C
        OUT 0x10
        LD #0x34
        OUT 0x10
        LD #0x00
        OUT 0x10

        LD #0x0C ; буква д
        OUT 0x10
        LD #0x38
        OUT 0x10
        LD #0x38
        OUT 0x10
        LD #0x0C
        OUT 0x10
        LD #0x00
        OUT 0x10

        LD #0x38 ; буква e
        OUT 0x10
        LD #0x2C
        OUT 0x10
        LD #0x34
        OUT 0x10
        LD #0x00
        OUT 0x10

        LD #0x1C ; буква л
        OUT 0x10
        LD #0x20
        OUT 0x10
        LD #0x1C
        OUT 0x10
        LD #0x00
        OUT 0x10

        LD #0x3C ; буква ь
        OUT 0x10
        LD #0x14
        OUT 0x10
        LD #0x0C
        OUT 0x10
        LD #0x00
        OUT 0x10

        LD #0x3C ; буква н
        OUT 0x10
        LD #0x10
        OUT 0x10
        LD #0x3C
        OUT 0x10
        LD #0x00
        OUT 0x10

        LD #0x3C ; буква и
        OUT 0x10
        LD #0x08
        OUT 0x10
        LD #0x10
        OUT 0x10
        LD #0x3C
        OUT 0x10
        LD #0x00
        OUT 0x10

        LD #0x3C ; буква к
        OUT 0x10
        LD #0x18
        OUT 0x10
        LD #0x24
        OUT 0x10
        LD #0x00
        OUT 0x10
        LD #0x00
        OUT 0x10
        RET

ORG 0x250
TUESDAY: LD #0x3C ; буква в
         OUT 0x10
         LD #0x2C
         OUT 0x10
         LD #0x34
         OUT 0x10
         LD #0x00
         OUT 0x10

         LD #0x20 ; буква т
         OUT 0x10
         LD #0x3C
         OUT 0x10
         LD #0x20
         OUT 0x10
         LD #0x00
         OUT 0x10

         LD #0x18 ; буква о
         OUT 0x10
         LD #0x24
         OUT 0x10
         LD #0x18
         OUT 0x10
         LD #0x00
         OUT 0x10

         LD #0x3C ; буква р
         OUT 0x10
         LD #0x28
         OUT 0x10
         LD #0x30
         OUT 0x10
         LD #0x00
         OUT 0x10

         LD #0x3C ; буква н
         OUT 0x10
         LD #0x10
         OUT 0x10
         LD #0x3C
         OUT 0x10
         LD #0x00
         OUT 0x10

         LD #0x3C ; буква и
         OUT 0x10
         LD #0x08
         OUT 0x10
         LD #0x10
         OUT 0x10
         LD #0x3C
         OUT 0x10
         LD #0x00
         OUT 0x10

         LD #0x3C ; буква к
         OUT 0x10
         LD #0x18
         OUT 0x10
         LD #0x24
         OUT 0x10
         LD #0x00
         OUT 0x10
         LD #0x00
         OUT 0x10
         RET

ORG 0x295
WEDNESDAY: LD #0x18 ; буква с
           OUT 0x10
           LD #0x24
           OUT 0x10
           LD #0x24
           OUT 0x10
           LD #0x00
           OUT 0x10

           LD #0x3C ; буква р
           OUT 0x10
           LD #0x28
           OUT 0x10
           LD #0x30
           OUT 0x10
           LD #0x00
           OUT 0x10

           LD #0x38 ; буква e
           OUT 0x10
           LD #0x2C
           OUT 0x10
           LD #0x34
           OUT 0x10
           LD #0x00
           OUT 0x10

           LD #0x0C ; буква д
           OUT 0x10
           LD #0x38
           OUT 0x10
           LD #0x38
           OUT 0x10
           LD #0x0C
           OUT 0x10
           LD #0x00
           OUT 0x10

           LD #0x1C ; буква а
           OUT 0x10
           LD #0x28
           OUT 0x10
           LD #0x1C
           OUT 0x10
           LD #0x00
           OUT 0x10
           LD #0x00
           OUT 0x10
           RET

ORG 0x350
THURSDAY: LD #0x30 ; буква ч
          OUT 0x10
          LD #0x10
          OUT 0x10
          LD #0x3C
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x38 ; буква e
          OUT 0x10
          LD #0x2C
          OUT 0x10
          LD #0x34
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x20 ; буква т
          OUT 0x10
          LD #0x3C
          OUT 0x10
          LD #0x20
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x3C ; буква в
          OUT 0x10
          LD #0x24
          OUT 0x10
          LD #0x14
          OUT 0x10
          LD #0x0C
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x38 ; буква e
          OUT 0x10
          LD #0x2C
          OUT 0x10
          LD #0x34
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x3C ; буква р
          OUT 0x10
          LD #0x28
          OUT 0x10
          LD #0x30
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x3C ; буква г
          OUT 0x10
          LD #0x20
          OUT 0x10
          LD #0x20
          OUT 0x10
          LD #0x00
          OUT 0x10
          LD #0x00
          OUT 0x10
          RET

ORG 0x400
FRIDAY:   LD #0x3C ; буква п
          OUT 0x10
          LD #0x20
          OUT 0x10
          LD #0x3C
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x3C ; буква я
          OUT 0x10
          LD #0x28
          OUT 0x10
          LD #0x34
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x20 ; буква т
          OUT 0x10
          LD #0x3C
          OUT 0x10
          LD #0x20
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x3C ; буква н
          OUT 0x10
          LD #0x10
          OUT 0x10
          LD #0x3C
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x3C ; буква и
          OUT 0x10
          LD #0x08
          OUT 0x10
          LD #0x10
          OUT 0x10
          LD #0x3C
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x3C ; буква ц
          OUT 0x10
          LD #0x08
          OUT 0x10
          LD #0x38
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x1C ; буква а
          OUT 0x10
          LD #0x28
          OUT 0x10
          LD #0x1C
          OUT 0x10
          LD #0x00
          OUT 0x10
          LD #0x00
          OUT 0x10
          LD #0x00
          OUT 0x10
          RET

ORG 0x440
SATURDAY: LD #0x18 ; буква с
          OUT 0x10
          LD #0x24
          OUT 0x10
          LD #0x24
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x34 ; буква у
          OUT 0x10
          LD #0x14
          OUT 0x10
          LD #0x3C
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x3C ; буква б
          OUT 0x10
          LD #0x24
          OUT 0x10
          LD #0x2C
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x3C ; буква б
          OUT 0x10
          LD #0x24
          OUT 0x10
          LD #0x2C
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x18 ; буква о
          OUT 0x10
          LD #0x24
          OUT 0x10
          LD #0x18
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x20 ; буква т
          OUT 0x10
          LD #0x3C
          OUT 0x10
          LD #0x20
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x1C ; буква а
          OUT 0x10
          LD #0x28
          OUT 0x10
          LD #0x1C
          OUT 0x10
          LD #0x00
          OUT 0x10
          LD #0x00
          OUT 0x10
          RET

ORG 0x480
SUNDAY:   LD #0x3C ; буква в
          OUT 0x10
          LD #0x2C
          OUT 0x10
          LD #0x34
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x18 ; буква о
          OUT 0x10
          LD #0x24
          OUT 0x10
          LD #0x18
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x18 ; буква с
          OUT 0x10
          LD #0x24
          OUT 0x10
          LD #0x24
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x3C ; буква к
          OUT 0x10
          LD #0x18
          OUT 0x10
          LD #0x24
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x3C ; буква р
          OUT 0x10
          LD #0x28
          OUT 0x10
          LD #0x30
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x38 ; буква e
          OUT 0x10
          LD #0x2C
          OUT 0x10
          LD #0x34
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x18 ; буква с
          OUT 0x10
          LD #0x24
          OUT 0x10
          LD #0x24
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x38 ; буква e
          OUT 0x10
          LD #0x2C
          OUT 0x10
          LD #0x34
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x3C ; буква н
          OUT 0x10
          LD #0x10
          OUT 0x10
          LD #0x3C
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x3C ; буква ь
          OUT 0x10
          LD #0x14
          OUT 0x10
          LD #0x0C
          OUT 0x10
          LD #0x00
          OUT 0x10

          LD #0x38 ; буква e
          OUT 0x10
          LD #0x2C
          OUT 0x10
          LD #0x34
          OUT 0x10
          LD #0x00
          OUT 0x10
          LD #0x00
          OUT 0x10
          RET

ORG 0x00
DATA: WORD ?


