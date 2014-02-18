# Homework 03

### Deadline
Monday, Feb 17th 2014 9:00am

### Guidelines:
In the **answer-sheet** folder you should find the following files:
  hw03-answer-sheet.rkt
  hw03-tests.rkt
  test-infrastructure.rkt

All of the above files will have to be in the same folder for the tests to work.

The questions that require you to write code are accompanied by test cases. You
can see in the description of the test case for which problem it is. To run the
tests check the "hw03-tests.rkt" file for further instructions.

### Possible penalties:
  - up to `20%` for submitting a file that does not compile. To compile, hit
    the "Run" button from the DrRacket UI when your file is open.

**Always** check the tests to see what the expected behaviour of the functions
you are given is supposed to be.

### General description
This homework should improve your recursion skills and it will help you master the
use of `lambda` functions.

#### 1. Parenthesis Balancing [10pt]

Write a function that takes a string as parameter and tells us whether or not
it contains balanced parentheses.

```racket
(balanced? "(balanced? ())")
; Will return #t
```

```racket
(balanced? ":'(")
; Will return #f
```

Prior to doing any computation it is *highly* recommended that you transform
the string to a list of characters using the `(string->list "some-string")` function.
Working recursively with the head and tail of a list will greatly reduce the
complexity of the problem.

You may assume:

- that the input is always a string
- an empty string or one with no parentheses is considered balanced
- as always, check the tests to see the full use cases of this function

#### 2. Fold [20pt]

In the second week lecture, we browesed through some powerful "higher order"
procedures Scheme has to offer. We ran though some examples and intuitively
explored a little bit as to how to use them correctly and effectively. `foldl`
is such a procedure. This exercise offer you more opportunities to play with it
yourself. It is a stripped down version of the standard fold function in Scheme,
but it provides a big picture of how foldl works.


##### Part A [10pt]

Implement a function `foldl-342` ("fold left") with the following signature:

```racket
(define (foldl-342 op zero-element lst) 'todo)
```

##### Input:

- `op`: is a two argument function
- `zero-element`: is expected to be the zero element of the operator function
  (e.g. 0 for +, 1 for *) but technically it can be any value.
- `lst`: a list of elements

##### Result:

a value computed by successively applying the `op` function to the each element
of the list and the result of previous `op` function calls (where no such result
exists the zero-element is used; basically, the zero-element is the value of the
base case)

```racket
 (foldl-342 + 0 '(1 2 3 4))

 ; Will return 10

 (string-append "one-string " "---" "two-string")
 ; Will return "one-string ---two-string"

 (foldl-342 string-append "" (list "!!!" "42"  "is " "answer " "the " ))
 ; Will return "the answer is 42!!!"

 ; Here we see that if we use 0 as the zero element of the multiplication
 ; function, the expression will yield the value 0.
 (foldl-342 * 0 '(1 2 3 4))
 ; Will return 0

 ; This expression computes the sum of squares of each element.
 (foldl-342 (lambda (x y) (+ (expt x 2) y)) 0 '(1 2 3 4 5))
 ; Will return 55
 ```

As you can see from this example the operator is always applied in the same order:

```racket
 (foldl-342 - 0 '(1 2 3 4))
 ; Will return 2

 (foldl-342 - 0 '(4 3 2 1))
 ; Will return -2
```

Since the minus operation is not commutative it gives different results
depending on the ordering of the elements.


##### Part B [10pt]

Implement a function `foldr-342` with the same signature as the one from 2a,
with the difference that the operator is applied in the opposite order as foldl.

```racket
 (foldr-342 - 0 '(1 2 3 4))
 ; Will return -2

 (foldr-342 - 0 '(4 3 2 1))
 ; Will return 2

 (foldr string-append "" (list "the " "answer " "is " "42" "!!!"))
 ; Will return "the answer is 42!!!"
 ```

#### 3. Andmap [10pt]

Implement the function `andmap-342` in terms of `foldl` or `foldr` (this time
use the ones from the standard library), with the signature:

```racket
 (define (andmap test-op lst) 'todo)
 ```


##### Input:

- `test-op`: a one argument function that returns a boolean
- `lst`: a list of elements

##### Output:

- `#t` if for all the elements in lst the function test-op returns #t
- `#f` if at least for one element the function test-op returns #f

```racket
 ; Odd is a library function that tests whether or not a number is odd
 (odd? 5)
 ; Will return #t

 (andmap-342 odd? '(1 3 5))
 ; Will return #t

 (andmap-342 odd? '(1 3 42))
 ; Will return #f

 (andmap-342 odd? '(1 6 42))
 ; Will return #f
 ```

Besides andmap, the standard library includes the function ormap which behaves
like andmap except that it returns #t if at least one of the element in the list
holds the property described by the function.

#### 4. Filter [10pt]

Implement a function called filter-342 with the signature:

```racket
 (define (filter-342 test-op lst) 'todo)
 ```

##### Input:
- `test-op`: a one argument function that returns a boolean
- `lst`: a list of elements

##### Output:
- a list containing all the elements of `lst` for which the test-op function
  returned #t

```racket
 (filter-342 odd? '(1 2 3 4 5 6 7 8 9 10))
 ; Will return '(1 3 5 7 9)

 (filter-342 number? '(42 'not-a-number "not-a-number"))
 ; Will return 42
 ```

#### 5. Map Reduce [10pt]

Implement a function `map-reduce` with the signature:

```racket
 (define (map-reduce m-op r-op zero-el lst) 'todo)
 ```

##### Input:
- `m-op`: a one argument operator
- `r-op`: a two argument operator
- `zero-el`: the zero element of the two argument operator
- `lst`: a list of elements

Output:
- a value resulted from combining each element of the list using `r-op` after
  you have applied `m-op` on said elements.

```racket
 (define add-forty-two
    (lambda (x) (+ x 42)))

 (map-reduce add-forty-two + 0 '(0 1 2))
 ; Will return 129

 ```

#### 6. Revisiting Series [10pt]

In the previous homework you had to compute a series of the form:

           (-1)^n
    An = -----------
           (n + 1)!

    for n >= 0
    Sn = 1 - 1/2 + 1/6 - 1/24 + ...

Write the computation using `map` and `foldl` as described previously.

**Hint**: We mentioned a similar case in class, please refer to lecture notes

#### 7. Matrix to Vector [10pt]

Consider the list representation of NxM matrices. In this representation a 3x4
matrix looks like the following:

```racket
 (define example-matrix 
   '((1 2 3 4)
     (5 6 7 8)
     (9 0 1 2))
  )
 ```

Write a function `matrix-to-vector` that takes an operation and a matrix as
arguments and outputs an M sized vector resulted from successively applying the
operation on the elements of a column.

```racket
 (matrix-to-vector + example-matrix)
 ; Will return '(15 8 11 14)

 (define string-matrix
  '(("a" "c" "e")
    ("b" "d" "f"))
   )

 (matrix-to-vector string-append string-matrix)
 ; Will return '("ab"  "cd"  "ef")
 ```

#### 8. Square Primes [10pt]

Implement a function `square-primes` with the signature:

```racket
 (define (square-primes list-of-numbers) 'todo)
 ```

Returns a list containing the squares of the primes in the "list-of-numbers"
parameter, in the order they appear, from left to right. Duplicates are allowed.

```racket
 (square-primes '(2 3 42 7 8 3 13))
 ; Will return '(4 9 49 9 169)
 ```

#### 9. Currying (Mmmm... curry) [10pt]

As was introduced in class, and discussed in homeowork02, currying is an
interesting mechanism in functional programming. Recall that the process of
writing a procedure of two parameters can be translated into a procedure of
**one** parameter that returns another procedure of one parameter. Trying
writing a currying procedure add-two-number, so that

```racket
((add-two-number 5) 7)
; Will return 12

((add-two-number 1) 1)
; Will return 2
```

Note: you curried procedure add-two-number has to be able to apply to its
arguments one at a time.

#### 10. Scala for loop.

Let us borrow the `for` expression from the [Scala](http://scala-lang.org/) language and implement something
very similar in Racket. To accomplish this we will be using [`define-syntax-rule`](http://docs.racket-lang.org/reference/stx-patterns.html).  

An example of what we would like to see is:  
```
> (for {a-var <- '(0 1 2 3 4)}
          yield (+ a-var 42)
  )
'(42 43 44 45 46)
```  

##### Syntax:
```
(for {<looping-variable> <- <a-list>}
      yield <expression>
)
```
Everything that is not in between angular brackets, `<>`, has to appear **as is**, and in that order.  

##### Semantics:
The for loop will bind an element of `<a-list>` to the `<looping-variable>`, then
it will compute `<expression>` and it will use the results of every iteration
to create a new list of the same length as `<a-list>`.

##### Note:
The solution can be written as a one liner.

### 11. Implicit currying

Now that problem 9 reminded you of currying let us explore how we can improve on it.  

You have two generic two argument functions, say: `(define (add x y) (+ x y))` and `(define (subtract x y) (- x y))`. Currying these is trivial, but as you may notice there is also "a lot" of boilerplate code:
  - from separate the arguments
  - from introduce `lambda` 

As very lazy programers we ask ourselves: can we avoid writing all those things **every** time we write a curried function? The answer to that questions is "kinda". To elaborate, we can easily do it for special cases with fixed number of parameters. Although possible to do it for the general case it would require knowledge of the Racket macro definition that we do not have the time to go into. (If you are feeling adventurous feel free to try it out! You need to know how to create parameter names at runtime).

Here is a proposal, we write a new syntax rule that looks and behaves pretty much like the well-known `lamba`, but it takes exactly **two** parameters.

##### Syntax:
```
(partially-applied-fun (<arg1-name> <arg2-name>) <expression>)
```

##### Semantics:
As I've said, it behaves like the `lambda` expression. It will return a two argument function that executes the `<expression>` and returns its value. Now here's the cool part: when calling the function, instead of supplying an actual value you can supply the symbol `'_`. If one or more of the two parameters are `'_` then, instead of computing the value of `<expression>`, the function will return a new function where the value of the parameter that was not `'_` is fixed! Here's an example:

```racket
;looks and behaves like a regular two argument function
> (define ratio (partially-applied-fun (numerator denominator) (/ numerator denominator)))
> (ratio 2 2)
1
;here's the cool thing:
>  (ratio 10 '_)
#<procedure>

;here we get a new function that then is called with the parameter 2!
> ((ratio 10 '_) 2)
5
```

# Good luck!
