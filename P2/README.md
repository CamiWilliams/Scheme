# Homework 02

### Deadline
Wednesday, Feb 5th 2014 11:59pm

### Guidelines:
In the **answer-sheet** folder you should find the following files:
  hw02-answer-sheet.rkt
  hw02-tests.rkt
  test-infrastructure.rkt

All of the above files will have to be in the same folder for the tests to work.

The questions that require you to write code are accompanied by test cases. You can
see in the description of the test case for which problem it is. To run the tests
check the "hw01-tests.rkt" file for further instructions.

### Possible penalties:
  - up to `20%` for submitting a file that does not compile. To compile, hit
    the "Run" button from the DrRacket UI when your file is open.

### Tips
Read the [Functional Programmer's Toolkit](https://github.com/ComS342-ISU/course-info/blob/master/guides/fun-prog-toolkit.md).
And study the [currying example](https://github.com/ComS342-ISU/homework/blob/master/homework02/currying-example.md)
found in this homework's top folder.

**Always** check the tests to see what the expected behaviour of the functions
you are given is supposed to be.

### General description
This homework should improve your recursion skills and it will help you master the
use of `lambda` functions.

#### 1. Binary Search
Implement a function with the signature: `(binary-search lst elem)` where:
- `lst` is a list of elements
- `elem` is an element

The function will do **binary** search over the list and return `#t` if the list contains
the given element. It will return `#f` otherwise.

#### 2. Carpet

Implement a function with the signature: `(carpet n)` where:
- `n is an integer

The function will output the following lists (the results are pretty printed
for the purposes of diplay, your solution will not look this way):
```
> (carpet 1)
'((+ + +)
  (+ % +)
  (+ + +))

> (carpet 2)
'((% % % % %)
  (% + + + %)
  (% + % + %)
  (% + + + %)
  (% % % % %))
```

#### 3. Y-Combinator
This exercise will teach you about using functions as parameters, this is also
referred to as "higher order procedures".

We want to implement the normal factorial function but with a twist. Instead of
using `define` like you have used in the past, we are going to do it without
named recursion. This means that you can't call yourself within yourself, like
with normal recursion.

The first part of this problem is to implement the `fact` syntax-rule in the
answer sheet. You are **forbidden** from using `define` or `letrec`. You should
only use lambdas (as well as basic operators, such as cond, =, *, etc.) for
construction.

**Hint**: This may require multiple lambdas...

The second part is to implement the `fact-alt` function. This will use the
canonical Y combinator function (given to you). You need to write the parameters
for the `lambda` because it will take argument(s) as well as the body of the
lambda. You **cannot** use the `fact` syntax-rule from the first part of the
problem; it must be reimplemented.

For example, if you decide that your function needs one parameter and just
returns the value, your solution would look like this:

```racket
(define (fact-alt x)
  ((Y
     (lambda (n)
       n
       )
     ) x))
```
**Hint**: Chapter 9 in the Little Schemer may be of assistance...

#### 4. Functional set
This exercise will train your ability to use lambda functions and, hopefully,
it will change the way you think about programming in general.

We want to implement a `set` data-structure. For simplicity this set will only
contain numbers. But instead of thinking of sets like a chunk of memory that simply
contains numbers, we will think of sets in terms of their `characteristic function`,
i.e. a one argument function that tells you whether or not the given argument is in
the set. As an example, the implementation of `singleton-set` is already given.
This function returns a `set`(as you can see it is actually a function) that
contains only one element.
```
> (define (singleton-set x)
  (lambda (y)
    (equal? x y)
    )
  )
> (define set (singleton-set 3))
> (set 3)
#t
> (set 4)
#f
```
Implement the remaining functions. Instructions can be found in the answer sheet.

As you will see this type of implementation, although very concise and powerful
when you want to query whether or not an element is in a set, it is limited when
you try and query all the elements in the set. Therefore, you may assume that
the sets can only contain values between 1 and 100.

**Hints:**
- the functions up until "exists?" can be written as one liners and do not
  require recursion or other functional operations to solve.
- just because a function has the word `map` in it, it doesn't mean you have
  to use the function `map` to implement it. `map` is a functional operation
  with well defined behavior that is not tied to any implementation.
- think about what it means for an element to be in a set, rather than how to
  implement it.

#### 5. Functional map

This exercise is similar to the previous one. But this time we will implement a `map`
datastructure that stores `(key, value)` pairs. Its characteristic function takes one
argument, a `key`, and return the value associated with the `key` or the symbol `'not-found`
if no such mapping exists.

The last fuction, `keys` will return a set containing all the keys stored in the map.
This set should use the representation you just implemented for the previous problem.

# Good luck!
