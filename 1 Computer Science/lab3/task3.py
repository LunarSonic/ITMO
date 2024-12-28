import re
def is_valid(cron_exp):
    exp = cron_exp.split(" ")
    if len(exp) == 5:
        minute = re.fullmatch(r"^(((?:[0-5]?\d)(?:-([0-5]?\d))?(?:,(?:[0-5]?\d)(?:-(?:[0-5]?\d))?)*)|\*|\*\/(?:[1-5]?[1-9]))$", exp[0])
        hour = re.fullmatch(r"^((?:\d|1\d|2[0-3])(?:(?:-(?:\d|1\d|2[0-3]))?(?:,(?:\d|1\d|2[0-3])(?:-(?:\d|1\d|2[0-3]))?)*)|\*|\*\/(?:[1-9]|1\d|2[0-3]))$",exp[1])
        day_of_the_month = re.fullmatch(r"^(((?:[1-9]|[12]\d|3[01])(?:(?:-(?:[1-9]|[12]\d|3[01]))?|(?:,(?:[1-9]|[12]\d|3[01])(?:-(?:[1-9]|[12]\d|3[01]))?))*)|\)|\*\/(?:[1-9]|[12]\d|3[01]))$",exp[2])
        month = re.fullmatch(r"^((?:[1-9]|1[012]|jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec)(?:(?:-(?:[1-9]|1[012]|jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec))?|(?:(?:,(?:[1-9]|1[012]|jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec)(?:-(?:[1-9]|1[012]|jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec))?)*))|\*)$",exp[3], re.IGNORECASE)
        day_of_the_week = re.fullmatch(r"^(^((?:[0-6]|sun|mon|tue|wed|thu|fri|sat)(?:(?:-(?:[0-6]|sun|mon|tue|wed|thu|fri|sat))?(?:,(?:[0-6]|sun|mon|tue|wed|thu|fri|sat)(?:-(?:[0-6]|sun|mon|tue|wed|thu|fri|sat))?)*)|\*)$)",exp[4], re.IGNORECASE)
        res = [minute, hour, day_of_the_month, month, day_of_the_week]
        if None not in res:
            print("Valid")
        else:
            print("Invalid")
    else:
        print("mistake!!!")
is_valid("60 */19 10 aug 3-5")  # 60
is_valid("*/9 19-24 10,11-15 DEC SAT")
is_valid("10 14,20-23 10-11 feb,jul mon-fri")
is_valid("15 18 */16 jan tue,fri")  # */34
is_valid("* */9 17 10 2,4")
is_valid("888888********")
is_valid("54 */795 ")
is_valid("* */* * * * *")



