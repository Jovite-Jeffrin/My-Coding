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

### Seeding
Sam is planting trees on the upper half region (separated by the left diagonal) of the square shared field. For every value of ‘N’, print the field if the trees are represented by ‘*’.

![image](https://github.com/user-attachments/assets/a826f27a-61a6-4415-8d65-f81bf6bd19b0)
```python
def seeding(n: int) -> None:
    # Write your solution here.
    for i in range(n,0,-1):
        for j in range(i):
            print("* ",end="")
        print("")
```

### Reverse Number Triangle
Aryan and his friends are very fond of the pattern. For a given integer ‘N’, they want to make the Reverse N-Number Triangle.

![image](https://github.com/user-attachments/assets/028d3f0e-03b2-471e-b324-0c9691aec57a)
```python
def nNumberTriangle(n: int) -> None:
    # Write your solution here.
    for i in range(n,0,-1):
        for j in range(i):
            print(j+1," ",end="")
        print("")
```

### Star Triangle
Ninja was very fond of patterns. For a given integer ‘N’, he wants to make the N-Star Triangle.

![image](https://github.com/user-attachments/assets/24add8c4-ce23-4df1-b5a3-372634464dad)
```python
def nStarTriangle(n: int) -> None:
    # Write your code here.
    for i in range(1, n+1):
        print(' '*(n-i)+'*'*(2*i-1)+' '*(n-i))
```

### Reverse Star Triangle
Ninja was very fond of patterns. For a given integer ‘N’, he wants to make the Reverse N-Star Triangle.

![image](https://github.com/user-attachments/assets/2e2ecd5b-7f86-4ba9-af87-89e8a81c289c)
```python
def nStarTriangle(n: int) -> None:
    # Write your code here.
   for i in range(n, 0, -1):
    
        # Inner loop to print space
        for j in range(i, n):
            print(" ", end="")
        
        # Inner loop to print star
        for j in range(1, 2 * i):
            print("*", end="")
        
        # Ending line after each row
        print()
```
