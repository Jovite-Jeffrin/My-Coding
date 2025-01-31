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

###  N-Triangles
Sam is making a Triangular painting for a maths project. An N-dimensional Triangle is represented by the lower triangle of the pattern filled with integers starting from 1. For every value of ‘N’, help sam to print the corresponding N-dimensional Triangle.

![image](https://github.com/user-attachments/assets/2d51c41c-db83-47c7-8550-82e81d317d2b)
```python
def nTriangle(n:int) ->None:
    # Write your solution here.
    for i in range(1,n+1):
        for j in range(0,i):
            print(j+1,end=" ")
        print("")
```

###  Triangle
Sam is making a Triangular painting for a maths project. An N-dimensional Triangle is represented by the lower triangle of the pattern filled with integers representing the row number. For every value of ‘N’, help sam to print the corresponding Triangle.

![image](https://github.com/user-attachments/assets/87f8b991-2957-4d3f-a7f7-3ca7579cb45b)
```python
def triangle( n:int) ->None:
    # Write your solution here.
    for i in range(1,n+1):
        for j in range(0,i):
            print(i,end=" ")
        print("")
```
