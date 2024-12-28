def check(code):
    a = set(code)
    b = a - {'0', '1'} #множество без таких элементов, как 0 и 1
    if (len(b) > 0) or len(code) != 7:
        print("Вы ввели не строку из 7 символов, состоящую из '0' и '1'")
        exit(1)
num = input()
check(num)
l = list(num)
c = list(map(int, l))
inf_bits = [num[2], num[4], num[5], num[6]]
s1 = str((c[0]+c[2]+c[4]+c[6]) % 2)
s2 = str((c[1]+c[2]+c[5]+c[6]) % 2)
s3 = str((c[3]+c[4]+c[5]+c[6]) % 2)
synd = (s1+s2+s3)[::-1]
s = int(synd, 2)
if s != 0:
    if s == 1:
        print("Ошибка в r1")
    elif s == 2:
        print("Ошибка в r2")
    elif s == 4:
        print("Ошибка в r3")
    elif s == 3:
        print("Ошибка в i1")
        inf_bits[0] = str(1 - int(inf_bits[0]))
    elif s == 5:
        print("Ошибка в i2")
        inf_bits[1] = str(1 - int(inf_bits[1]))
    elif s == 6:
        print("Ошибка в i3")
        inf_bits[2] = str(1 - int(inf_bits[2]))
    elif s == 7:
        print("Ошибка в i4")
        inf_bits[3] = str(1 - int(inf_bits[3]))
    correct_code = ''.join(inf_bits)
    print("Правильное сообщение: " + correct_code)

