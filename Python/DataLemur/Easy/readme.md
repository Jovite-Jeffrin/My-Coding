## Easy Python Data structure practice questions

### Factorial formula
Given a number n, write a formula that returns n!

```python
def factorial(n):
  if n == 0:
    return 1
  elif n == 1:
    return 1
  return n * factorial(n-1)
```

### Fizz Buzz Sum
Write a function fizz_buzz_sum to find the sum of all multiples of 3 or 5 below a target value. For example, if the target value was 10, the multiples of 3 or 5 below 10 are 3, 5, 6, and 9. Because 3+5+6+9=23, our function would return 23.

```python
def fizz_buzz_sum(target):
  value = 0
  for i in range(target):
    if (i % 3 == 0) or (i % 5 == 0):
      value += i
  return value
```
