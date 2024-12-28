def g(x):
    a = set(x) - {'0', '1'}
    if len(a) > 0:
        print("There is an error")
        exit(1)
def f(x):
    a = [1, 1]
    for i in range(2, x+1):
        a.append(a[i-2]+a[i-1])
    return a
num = int(input("Enter the fibonacci number: "))
l = str(num)
g(l)
ln = len(str(num))
new_fib = f(ln)[1:]
b = str(num)[::-1]
res = 0
for j in range(len(b)):
    c = int(b[j]) * new_fib[j]
    res += c
print(f'The decimal result: {res}')

