# Exam 1 Notes
## Wednesday October 9th

## Models of Computation

1. VonNeumann Architecture (Classical Computation)
    - CPU, RAM, Process Layout (Text, Globals, Heap, Stack (down)).
        - Main Event for Programming Languages
2. Neural Network
    - Directed graph of weighted edges with a transfer function.
        - Leading nodes (no edges going in) are inputs and given data.
        - Sum the weights of all the nodes leading to that node, and then pass that value through the transfer function.
        ```T(sum(weights*inputs to that node))```
        - ML amounts to designing the graph and optimizing the weights.
3. Probabilistic Classical & NN
    - x = 3 with prob .7 and 82 with prob .3
    - Quantum computer

## Categories of Languages
1. Procederal
2. Function
3. Constraints / Logic
4. Object Oriented

Many languages are combinations of these.

### Questions:

- **When is procederal programming style a good idea?**\
Procedural programming focuses on solving problems by following a set of logical steps, but it does not have a focus on immutability. This type of style is very useful for solving simpler, more straight-forward problems rather than something that may not follow a set of steps everytime. For example, this style of programming would be more useful in a program where you are automating a certain operation and it is always done in a specific order.
- **Why is functional programming style popular in web applications?**\
Function programming is commonly used in web applications because it focuses on pure functions and immutability, adding on new functions to solve problems instead of making changes to existing code/structures. By having pure functions that only every return that same output for a certain input, it helps idenitify/reduce bugs in the codes. By having smaller, reuseable functions with immutablility, it allows better for code to be run in parallel with other code.
- **What is the basic syntax of CSS?**\
CSS stands for cascading stylesheet and it is made up of selectors, properties, and values that are used to define elements for HTML. Using CSS allows you to create selectors that you can reuse without have to type out every single time on the main HTML code which reduces the complexity of the code and makes it easier to make changes to that element without having to go through every iteration of it. The 'selector' is the name of the element you are creating/defining, the 'property' is what you want to assign a value for, like the font, font size, or a background color. The 'value' is what the property gets set to, such as a number, a color like 'red', hexcode, or rgb value, etc.  
- **What is the purpose of HTML? What kind of language is it?**\
HTML stands for hypertext markup language and is used mainly for web applications in order to create/organize things like text, boxes, images, and actions (buttons, drop downs) onto a page. 
- **Why is SQL a logic/constraint language?**\
SQL is a language used for creating/modifying databases in which it has tables for data and create relations between the data in these tables.
- **Why are logic languages used for user interfaces?**\
Logic programming is 
- **Why are general purpose languages used to write machine learning models?**\
General purpose languages are
- **Convert this procedural program into functional style:**
    ```C
    double sum_powers(int a, int b, int p){
        double sum = 0;
        for(int i = a; i <= b; ++i){
            sum += pow(i, p);
        }
        return a;
    }
    ```
    Converting this code into a functional style would look something like:
    ```C
        double sum_powers(){
            if(a <=> b)
                return pow(a, p) + sum_powers(a + 1, b, p);
            return 0;
        }
    ```
    This function uses recursion by calling the function in the return rather than looping through a for loop.
- **Why do side effects breaks functional programming style?**\
A side effect in programming is when a function or piece of code relies on or changes something that it is not intended to do. For example, if a program has a global variable called 'sum' set to zero, and a function that takes in two numbers and returns the sum, but uses the global sum variable to set the result of the two numbers to, this changes a global variable and therefore the function is no longer an immutable function.