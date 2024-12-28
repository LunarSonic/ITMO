import re
from enum import Enum
class Brackets(Enum):
    SpaceElement = "  "
    ListElement = "- "
#конвертируем структуру данных Python в формат YAML
def getyaml(json_text, space = ""):
    yaml_text = ""
    if type(json_text) == dict:
        for key, value in json_text.items():
            yaml_text += f"\n{space}{key}:"
            yaml_text += getyaml(value, space + "")
    elif type(json_text) == list:
        for item in json_text:
            if type(item) == dict:
                yaml_text += f"\n{space}{Brackets.ListElement.value}{getyaml(item, space + '  ').strip()}"
            else:
                yaml_text += f"\n{space}{Brackets.ListElement.value}{item}"
    elif type(json_text) == str:
        yaml_text += f" {json_text}"
    return yaml_text

#регулярные выражения для разных типов данных
regex_num = re.compile(r"(-?(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+-]?\d+)?)")
regex_str = re.compile(r'"((?:[^\\"]|\\["\\/bfnrt]|\\u[0-9a-fA-F]{4})*?)"')
regex_true = re.compile(r"\btrue\b")
regex_false = re.compile(r"\bfalse\b")
regex_null = re.compile(r"\bnull\b")

def parse_str(s, ind):
    match = regex_str.match(s[ind:]) #если строка соответствует шаблону для числа
    if match:
        return match.group(1), ind + match.end() #возвращаем строку и новый индекс
    return None, ind

def parse_num(s, ind):
    match = regex_num.match(s[ind:])
    if match:
        num_str = match.group(1) #представление числа в виде строки
        try:
            num = float(num_str) if '.' in num_str or 'e' in num_str else int(num_str)
            return num, ind + match.end() #возвращаем int или float
        except ValueError:
            raise ValueError(f"Format of number is invalid: {num_str}")
    return None, ind

def parse_literal(s, ind):
    for regex, value in [(regex_true, True), (regex_false, False), (regex_null, None)]:
        match = regex.match(s[ind:])
        if match:
            return value, ind + match.end()
    return None, ind

#пропускаем пробельные символы и обновляем индекс
def miss_whitespace(s, ind):
    while len(s) > ind and s[ind].isspace():
        ind += 1
    return ind

def parse_array(s, ind):
    if s[ind] != '[': #проверка на начало массива с '['
        return None, ind
    ind += 1 #пропускаем '['
    items = []
    while len(s) > ind:
        ind = miss_whitespace(s, ind)
        if len(s) > ind and s[ind] == ']': #конец массива, возвращаем пустой массив
            return items, ind+1
        item, ind = parse_value(s, ind) #парсим элемент массива
        if item is None:
            raise ValueError(f"Value is invalid in the array at position {ind}")
        items.append(item)
        ind = miss_whitespace(s, ind)
        if len(s) > ind and s[ind] == ']':
            return items, ind+1
        elif ind >= len(s) or s[ind] != ',': #проверка на наличие запятой
            raise ValueError("Expected ',' in the array")
        ind += 1

def parse_object(s, ind):
    if s[ind] != '{': #проверка на начало массива с '{'
        return None, ind
    ind += 1
    objects = {}
    while len(s) > ind:
        ind = miss_whitespace(s, ind) #пропускаем пробелы
        if len(s) > ind and s[ind] == '}':
            return objects, ind+1
        key, ind = parse_str(s, ind) #парсим ключ
        if key is None:
            raise ValueError(f"The key is invalid or missed in the object at position {ind}")
        ind = miss_whitespace(s, ind)
        if ind >= len(s) or s[ind] != ':': #проверка на наличие ':'
            raise ValueError("Expected ':' in the object")
        ind += 1
        value, ind = parse_value(s, ind) #парсим значение
        if value is None:
            raise ValueError(f"The value for the key {key} is missed in the object at position {ind}")
        objects[key] = value #добавляем пару ключ:значение в объект
        ind = miss_whitespace(s, ind)
        if len(s) > ind and s[ind] == '}':
            return objects, ind+1
        elif ind >= len(s) or s[ind] != ',': #проверка на наличие запятой
            raise ValueError("Expected ',' in the object")
        ind += 1

def parse_value(s, ind):
    ind = miss_whitespace(s, ind)
    if ind >= len(s):
        raise ValueError("Unexpected end of input")
    all_parsers = [parse_str, parse_num, parse_literal, parse_array, parse_object]
    for parser in all_parsers:
        res, new_ind = parser(s, ind)
        if res is not None:
            return res, new_ind
    raise ValueError("Invalid JSON value")

def json_to_yaml():
    try:
        with open('schedule.json', 'r', encoding='utf-8') as json_file:
            json_text = json_file.read()
            data, ind = parse_value(json_text, 0)
            if ind < len(json_text):  #если остался текст после разбора
                raise ValueError(f"Extra text after JSON at position {ind}: {json_text[ind:]}")
            yaml_res = "schedule:" + getyaml(data.get("schedule", []))
        with open('extratask2_output.yml', 'w', encoding='utf-8') as yaml_file:
            yaml_file.write(yaml_res)
    except FileNotFoundError:
        print("The file wasn't found")
    except ValueError as error:
        print(f"Error in parsing {error}")

json_to_yaml()