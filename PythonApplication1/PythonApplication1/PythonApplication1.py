def Test(n):
    print('Function called with ', n)

print('This is python...')

for i in range(10):
    print('For loop value: ', i)
    Test(i)

# Python 3: Fibonacci series up to n
def Fibonacci(n):
    a, b = 0, 1
    while a < n:
        print(a, end=' ')
        a, b = b, a+b
    print()

Fibonacci(10000)
