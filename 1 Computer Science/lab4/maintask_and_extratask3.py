from enum import Enum
class Brackets(Enum):
    SpaceElement = "  "  #2 пробела для отступа
    ListElement = "- "   #для элемента списка
#конвертируем структуру данных Python в формат YAML
def getyaml(json_text, space = ""):
    yaml_text = ""
    if type(json_text) == dict:
        for key, value in json_text.items():
            yaml_text += f"\n{space}{key}:" #добавляем ключ словаря к yaml_text
            yaml_text += getyaml(value, space + "") #вызов для вложенного элемента
    elif type(json_text) == list:
        for item in json_text:
            if type(item) == dict: #если элемент списка-вложенный словать
                yaml_text += f"\n{space}{Brackets.ListElement.value}{getyaml(item, space + '  ').strip()}"
            else: #если это не словарь, то добавляем как элемент списка
                yaml_text += f"\n{space}{Brackets.ListElement.value}{item}"
    elif type(json_text) == str:
        yaml_text += f" {json_text}"
    return yaml_text
#пропускаем пробельные символы и обновляем индекс
def miss_whitespace(s, ind):
    while ind < len(s) and s[ind].isspace():
        ind += 1
    return ind

#парсинг числа
def parse_num(s, ind):
    start = ind #записывыем начальный индекс
    if s[ind] == '-':
        ind += 1
    while ind < len(s) and s[ind].isdigit(): #целая часть числа
        ind += 1
    if ind < len(s) and s[ind] == '.': #дробная часть числа
        ind += 1
        while ind < len(s) and s[ind].isdigit():
            ind += 1
    if ind < len(s) and s[ind] in 'eE': #экспоненциальная часть чсила
        ind += 1
        if s[ind] in '+-': #знак экспоненты
            ind += 1
        while ind < len(s) and s[ind].isdigit():
            ind += 1
    num_str = s[start:ind] #берём строку числа
    num = float(num_str) if '.' in num_str or 'e' in num_str else int(num_str)
    return num, ind #возвращаем число и обновлённый индекс

#парсинг строки
def parse_str(s, ind):
    ind = miss_whitespace(s, ind)
    if s[ind] != '"': #проверка на начало строки
        raise ValueError("Expected '\"' at the start of the string")
    ind += 1
    start = ind
    while s[ind] != '"': #теперь ищем конец строки
        if s[ind] == '\\': #проверка на экранированный символ
            ind += 2 #пропускаем экранированную последовательность
        else:
            ind += 1 #переходим к следующему элементу
    res = s[start:ind] #извлекаем строку
    ind += 1 #пропускаем кавычку, которая завершает строку
    return res, ind

#парсинг массива
def parse_array(s, ind):
    ind += 1
    array = []
    ind = miss_whitespace(s, ind)
    if s[ind] == ']': #проверка на пустой массив
        return array, ind+1
    while True:
        value, ind = parse_value(s, ind) #парсим элемент массива
        array.append(value)
        ind = miss_whitespace(s, ind)
        if s[ind] == ']': #если массив завершён
            return array, ind+1
        elif s[ind] != ',': #проверка на наличие запятой
            raise ValueError("Expected ',' in the array")
        ind += 1

#парсинг объектов
def parse_object(s, ind):
    ind += 1
    objects = {}
    ind = miss_whitespace(s, ind)
    if s[ind] == '}': #проверяем, пуст ли объект
        return objects, ind+1
    while len(s) > ind:
        ind = miss_whitespace(s, ind)
        if ind >= len(s) or s[ind] != '"': #ключ должен быть строкой
            #если ключа нет или JSON неправильный, то ошибка
            raise ValueError(f"Expected key at position {ind}")
        key, ind = parse_str(s, ind) #парсим ключ объекта
        if s[ind] != ':': #проверка на ':'
            raise ValueError("Expected ':' in the array")
        ind += 1
        value, ind = parse_value(s, ind) #теперь парсим значение
        if value is None:
            raise ValueError(f"The value for the key {key} is missed in the object at position {ind}")
        objects[key] = value #добавляем пару ключ:значение в объект
        ind = miss_whitespace(s, ind)
        if s[ind] == '}':
            return objects, ind+1
        elif s[ind] != ',':
            raise ValueError("Expected ',' in the array")
        ind += 1

#парсинг значений
def parse_value(s, ind):
    ind = miss_whitespace(s, ind) #пропускаем пробелы
    if ind >= len(s): #проверка на конец строки
        print(f"Unexpected end of input at position {ind}")
        return None, ind
    if s[ind] == '{':
        return parse_object(s, ind)
    elif s[ind] == '[':
        return parse_array(s, ind)
    elif s[ind] == '"':
        return parse_str(s, ind)
    elif s[ind].isdigit() or s[ind] == '-':
        return parse_num(s, ind)
    elif s[ind:ind + 5] == 'false':
        return False, ind + 5
    elif s[ind:ind + 4] == 'true':
        return True, ind + 4
    elif s[ind:ind + 4] == 'null':
        return None, ind + 4
    else:
        raise ValueError(f"Unexpected character '{s[ind]}' at position {ind}")

def json_to_yaml():
    try:
        with open('schedule.json', 'r', encoding='utf-8') as json_file:
            json_text = json_file.read()
            data, ind = parse_value(json_text, 0)
            if ind < len(json_text):  #если остался текст после разбора
                raise ValueError(f"Extra text after JSON at position {ind}: {json_text[ind:]}")
            yaml_res = "schedule:" + getyaml(data.get("schedule", []))
        with open('maintask_and_extratask3_output.yml', 'w', encoding='utf-8') as yaml_file:
            yaml_file.write(yaml_res)
    except FileNotFoundError:
        print("The file wasn't found")
    except ValueError as error:
        print(f"Error in parsing {error}")
json_to_yaml()
