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

---

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

---

### Contains Duplicate
Given an list of integers called input, return True if any value appears at least twice in the array. Return False if every element in the input list is distinct.

For example, if the input list was [1,3,5,7,1], then return True because the number 1 shows up twice. However, if the input was [1,3,5,7] then return False, because every element of the list is distinct.

```python
def contains_duplicate(input)-> bool:
  s = len(set(input))
  if len(input) == s:
    return False
  return True
```

---

### Intersection of Two Lists
Write a function to get the intersection of two lists.

For example, if A = [1, 2, 3, 4, 5], and B = [0, 1, 3, 7] then you should return [1, 3].

##### Method 1
```python
def intersection(a, b):
  return list(set(a).intersection(b))
```

##### Method 2
```python
def intersection(a, b):  
  ls = []
  for i in a:
    if i in b and i not in ls:
      ls.append(i)
  return ls
```
