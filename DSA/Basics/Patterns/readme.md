### N-Forest
Sam is making a forest visualizer. An N-dimensional forest is represented by the pattern of size NxN filled with ‘*’. For every value of ‘N’, help sam to print the corresponding N-dimensional forest.

![image](https://github.com/user-attachments/assets/ab9b1119-296b-4b86-ab0a-3cae44465da6)
```python
def nForest(n:int) ->None:
    # Write your solution here.
    for i in range(n):
        print("* "*n)
```

### N/2-Forest
Sam is making a forest visualizer. An N-dimensional forest is represented by the pattern of size NxN filled with ‘*’. An N/2-dimensional forest is represented by the lower triangle of the pattern filled with ‘*’. For every value of ‘N’, help sam to print the corresponding N/2-dimensional forest.

![image](https://github.com/user-attachments/assets/2de38d8e-d289-4acc-bfb3-94de7d24177b)
```python
def nForest(n:int) ->None:
    # Write your solution here.
    for i  in range(1,n+1):
        print("* "*i)
```
