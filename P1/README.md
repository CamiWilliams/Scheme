# Homework 01

### Deadline
Monday, Jan 27th 9am

### Guidelines:
In the **answer-sheet** folder you should find the following files:
  hw01-answer-sheet.rkt
  hw01-tests.rkt
  test-infrastructure.rkt

All of the above files will have to be in the same folder for the tests to work.

The questions that require you to write code are accompanied by test cases. You can
see in the description of the test case for which problem it is. To run the tests
check the "hw01-tests.rkt" file for further instructions.

### Possible penalties:
  - up to `20%` for submitting a file that does not compile. To compile, hit
    the "Run" button from the DrRacket UI when your file is open.

### Tips
In Racket/Scheme, all expressions are written between a pair of parentheses.
Whenever the interpreter encounters an open parenthesis, e.g.:  
`(+ 3 4)`  
it will expect that the first element of the list to be a function (except when using the `'` (quote) function); in Scheme operators are also functions (we will cover this a bit later).

The implication of this uniform way of treating things is that mathematical expression have to be written in infix notation (the operator comes first, the operands later) as opposed to the infix notation we see in Java; but this allows for addition to take an arbitrary number of operands:
```
> (+ 1 2 3 4)
10
```  

The ">" symbol is an indication that the expression following it is evaluated
in the interpreter.

# Part One

#### 1.
Translate the following arithmatic expression into Scheme's notation. Type the translation into Scheme's interaction window for checking.
  - `((3 + 3) * 9)`
  - `((6 * 9) / ((4 + 2) + (4 * 3)))`
  - `(2* ((20 - (91 / 7)) * (45 - 42)))`

#### 2.

Describe in words how to translate an algebraic formula into Scheme's notation.
Be sure to handle the general case.

#### 3.

Using Scheme/Racket's **define**, write definitions of variables x, y and z such that:
  - x has a value of 2 
  - y has a value of 3
  - z has a value of 4

#### 4.

Write and evaluate an `if` or `cond` expression in Scheme that uses the variables x, y and z. The value of this expression should be the sum of the two largest variables. If all variables are of the same value, the value of the expression should be 0 (zero).

#### 5.

Evaluate a similar `if` or `cond` expression that has as its value the sum of the two smallest of x, y and z. If all three are of the same value, the value of the function is 0 (zero).

#### 6.

**Without** using an `if` or `cond` expression, write an expression that uses both variables `x` and `y` such that:
  - if `x` and `y` are equal then the value of the expression is `#t`
  - the value of the expression is `#f` otherwise

#### 7.

What is de difference between the following two statements?
```
(define forty-two 42)
(define (forty-two) 42)
```

### Tips for the next section:

Scheme offers a "one size fits all collection", list. It is a heterogeneous collection, i.e. it can store any number of types of values at the same time. Very important for you to remember is that lists are immutable; all operations on lists (`car`, `cdr` `cons`, etc.) do not modify the original list, but rather construct a new one. We will study the implications this fact has on our programming style in later homework assignments. For now, we will focus only on constructing lists.

#### 8.

Experiment with '``(quote) in the Scheme interpreter.  Try, for example:
  - `> 'name` 
  - `> '+`
  - `> '(/ 4 2)`
  - `> 'gargleblaster`
and the unquoted versions of the above and make note of the differences.  

In English, give a precise answer the following question: what does `'` do?

#### 9.

A similar procedure to `'` (quote) is `list`. What is the difference between `'` and list?    
Hint: try using variables and function calls in conjunction with the two.

#### 10.

What can you do with a string in Scheme that you can't do with a symbol?  
Why is there a distinction between strings and symbols in Scheme?   

(Hint: look at the Revised Report on Scheme, available from the Racket and from  
the course resources web page, to see the operations that Scheme defines for these  
types.)  

#### 11.
 
Using *only* the Scheme procedure `list`, numbers, and quoted symbols such as `'*`, `'name`, and `'james`, write Scheme expressions that return the following lists:

```
(4 2 6 9)
```

```
(spaceship
       (name(serenity))
       (class(firefly)))
```

```
(2 * ((20 - (91 / 7)) * (45 - 42)))
```

(Note that the line breaks and indentation in these lists do not matter; the interpreter will print out the value of your answer without this indentation, which is OK. We are asking for you to create the values displayed below, not the printing displayed below.  So don't use `\newline` or `#\space` in your answer


#### 12.
Suppose we are writing code for a procedure in which the variable `lst` is bound to a
list of symbols.  Suppose further that `lst` has the value:  

`'(a b c)`

For each of the following lists, write an expression that uses the variable `lst` and recreates them:
  - `'(d a b c)`
  - `'(a b d a b)`
  - `'(b c d a)`

##### Hint:
Use the functions `cons`, `car`, and `cdr`, or other list accessor shorthands
found here: http://docs.racket-lang.org/reference/pairs.html?q=cadr&q=rackunit#(part._.Pair_.Accessor_.Shorthands)

#### 13.

The standard library provides two functions `eq?` and `equal?` (the question mark
is part of the name). Experiment with these two functions and concisely describe
the difference between the two.

#### 14.

Using string manipulation function like `string-append`, `number->string`, `symbol->string`, or the `to-string` function found in the **util-lib.rkt* file; define the function `create-error-msg` that behaves in the following manner: 

```
> (create-error-msg 'answer-to-everything 10)
"This is a custom message. Symbol 'answer-to-everything was paired with value 10 instead of 42" 
```
You may assume that the first argument is always a symbol and that the second one is always a number.

#### 15.

A common debugging practice is to simply print out relevant information. During this course you will encounter two functions that do that:

```
> (display 42)
42
```

```
> (print 42)
42
```

The semantic difference between the two is not relevant for this course. However, you are encouraged to look into this matter by yourself.  

To print a newline evaluate the function:
```
> (newline)
```

Because the branches of an "if" instruction can contain only one instruction each,
in order to print any relevant information from any branch and still do computation
you can use the `begin` instruction:  

```
> (if true 
      (begin (print "computing 42") (newline) (+ 12 30))
      (print "dead code")           
   )
```

A begin instruction can contain 0 or more instructions. The value of the begin instruction is *always* the value of the last instruction. As you can see from the above example, the first two instructions produce side effects (printing) while the last instruction computes a value which is then returned as the  value of the "begin" instruction and then as the value of the "if" instruction.  

**You do not have to do anything for this problem, just experiment a bit.**

##### Important note:
The following two statements might look very similar if evaluated in the interpreter, but they are fundamentally different: 
```
> (define (fun-version-one) 42)
> (fun-version-one)
42
```
```
> (define (fun-version-two) (print 42))
> (fun-version-two)
42
```
At no point will functions that **print** out results be accepted as correct when they are supposed to **return** a value. It's no different than in any other programming language, using values that have been printed out is much more difficult, tedious and often times completely incorrect semantically.

#### 16.

Name two types of errors that in Java are detected at compile time but in Scheme/Racket are not. Write an example for each one. You can also use any standard library function in your example.

# Part Two
Now that we've covered the basics of the programming language it's time to write some meaningful functions. 

Given your background in Java you are probably extremely familiar and comfortable with using loops and an iterative approach to process arrays and collections. In functional programming loops are not very common, programmers rely on the recursive nature of the data structures they use, so they write recursive algorithms to do the computation.  

As you might have noticed lists can be define recursively as follows:  
```
<list> ::=  null
          | data <list>
```  
the above is BNF(Backus-Naur form), we will learn more about it further down the line.

In plain english, the above description says that a list is either `null` (empty) or it contains some data and another list. This is similar to how you, probably, implemented linked lists in your algorithms classes; a node contained some data and a reference to the next node, thus defining a node in terms of itself.  

In Racket, say we have the list `l`:
```
>(define l '(1 2 3))
>(car l); this would correspond to the "data" element described in the grammar
        ; from now on referred to as the "head" of the list
>(cdr l); this value corresponds to the remainder of the list, from now on
        ; referred to as the "tail" of the list.
``` 

To better grasp the concept, evaluate the following expression and relate the 
return value of the function to the recursive definition of a list:  
`> (cdr '(one-element))`

The implication of the above on how we process lists is that we will be using
recursive algorithms. For example, consider the very simple function that takes
a list of numbers as arguments and adds them together:

```
(define (add-all lst)
   ;our base case, or stopping condition. If the list is empty then we return 0
   (if (null? lst)
        0
        ;otherwise we add the head of the list to whatever value is computed for the rest of the list
        (+ (car lst) (add-all (cdr lst))))
)
```

#### 17. list-of-even-numbers

Implement a function `list-of-even-numbers?` that takes a list as argument and tells whether or not the list contains **only** even numbers.

```
> (list-of-even-numbers? '(4 20 16 2)) 
#t
> (list-of-even-numbers? '(1))
#f
> (list-of-even-numbers? (list "a-string" 'a-symbol 42))
#f
```  

**You may not assume that the list will contain only integers.**

Note:
Generally, in Scheme/Racket, when you encounter a function that ends in a
question mark, "?", it is an indication that this function never terminates
in an error, but returns either #t xor #f. Such functions are called predicates.  

Hint:  You may want to use the library functions "number?" and "even?". These also follow the rule of thumb described above.


#### 18. Series

In mathematics, a series, is a sum of the terms of a progression. A sequence is a string of numbers that progress based on a certain rule. For instance, the progression described by the rule `An = 2*n` results in:  
`0 2 4 6 8 10 ?`  
Then the series constructed from this progression would be:
  `Sn = 0 + 2 + 4 + 6 + 8 + 10 + ?`  

Write a function, for each of the series bellow, that computes the sum up to
the nth term (inclusively), where n is the only parameter of the function.
Look at the tests to see what the computed values are.  

###### 18.a [5p]
```
        1
An = -------
      (n^2)
```
for `n > 0 `,  `Sn = 1/1 + 1/4 + 1/9 + 1/16 + ?`  

###### 18.b [5p]  
```
       (-1)^n
An = -----------
       (n + 1)!
```  

for `n >= 0`, `Sn = 1 - 1/2 + 1/6 - 1/24 + ?`  

##### Note:
You will notice that the test values are written as fractions. By default, Racket,
does not use floating point notation to do arithmetic because it is imprecise. To
force it to use floating point you have to write a `#i` in front of at least one
number that is involved in the computation. For instance:  
```
> (/ 1 2)
1/2

> (/ #i1 2)
0.5
```
You can find more information on how numbers are represented in Racket here:
http://docs.racket-lang.org/guide/numbers.html 


