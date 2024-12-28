import json
import csv
def json_to_csv():
    with open('schedule.json', 'r', encoding='utf-8') as json_file:
        data = json.load(json_file)
    with open('schedule.csv', 'w', encoding='utf-8') as csv_file: #созадём csv файл
        writer = csv.writer(csv_file, delimiter=';') #создаём объект для записи данных в csv файл,
        # ';' - разделитель между столбцами
        #дальше записываем элементы в одну строку(это наши заголовки для столбцов)
        writer.writerow([
            "week", "day", "subject", "type", "time_start", "time_end",
            "teacher", "room", "building"
        ])
        #проходимся по каждому элементу массива, schedule - корневой элемент
        for item in data["schedule"]:
            week = item["week"] #берём номер недели из текущего элемента
            day = item["day"] #берём день недели из текущего элемента
            for lesson in item["lessons"]:
                #каждое поле добавляется в определённый столбец
                writer.writerow([
                    week, day, lesson["subject"], lesson["type"], lesson["time_start"],
                    lesson["time_end"], lesson["teacher"], lesson["room"], lesson["building"]
                ])
json_to_csv()
