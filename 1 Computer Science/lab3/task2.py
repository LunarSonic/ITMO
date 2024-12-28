import re
def check_substring(string):
    matches = re.search(r"ВТ((?:\s)(?:-)?(?:\w+)?(?:[А-Яа-яЁё]*)?(?:\s)?){0,4}\sИТМО", string)
    if matches != None:
        print(matches.group())
    else:
        print("None")
check_substring("Кафедра ВТ считается классной в ИТМО?")
check_substring("Студенты с ВТ не могут сдать лабу по ОПД с первого раза")
check_substring("Прошу меня отчислить с кафедры ВТ в ИТМО")
check_substring("Первокурскники с ВТ изучают дискретку в ИТМО")
check_substring("Информатика - крутой и полезный предмет в ИТМО")
#check_substring("ВТ поп опрор оаоаоа ИТМО рлрл ВТ ИТМО ВТ909рр ИТМО вапроВТИТМО")
