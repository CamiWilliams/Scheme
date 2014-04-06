# Homework 05

### Due Friday, Match 14th, 9:00pm

### Suggested reading: EOPL 2.4

This homework is designed to give you more exposure to `define-datatype`, a syntax rule
available in the `eopl` library (meaning it comes with your textbook, and its not part of
the stardard Racket language).

`define-datatype` allows you to easily define recursive datatypes, it automatically
generates:
* a constructor for each variant
* one predicate for the top level datatype, e.g. `env?`, it doesn't generate one predicate per variant.

```racket
> (#%require (lib "eopl.ss" "eopl"))
;it take two top level parameters
> (define-datatype name-of-datatype name-of-predicate
     ;each variant is described by a list of field-name predicate pairs
     ;here f1, f2 have to be numbers
     ;f3 is a list-of numbers, please refer to the "list-of" function from the
     ;"eopl" library for more information (you can look it up in the online racket index)
    (variant1 (f1 number?)
              (f2 number?)
              (f3 (list-of number?))
            )

  ;as you can notice, the fields may be named how you please, and you can use
  ;custom predicates to describe them
  (variant2 (i-can-give-the-fields-whatever-name-I-want string?)
            (n-or-s number-of-string?)
            ;it is possible to use the predicate of the data-type we are currently
            ;defining
            (field-of-this-datatype name-of-predicate)
            )

   (empty-variant)
  )

(define (number-of-string? x)
  (or (number? x) (string? x))
  )
```
The role of extractors and predicates is taken over by the `cases` expression, syntactically
it resembles a `cond` expression:

```
(define (fun adt)
  (cases name-of-datatype adt

    (variant1 (f1 f2 f3) #|expression that can use f1 f2 f3, each of
                          which are bound to the values of the three fields
                        of this variant|#
              (+ f1 f2))

    (variant2 (dont-have-to-use-same-name-as-in-the definition but-it-is recommended) 42)

    (else (raise "If you leave out any variants from the cases expression
                  then the else clause has to be present"))
    )
  )
```
Please read section 2.4. very carefully as define-datatype is specific to our
textbook (EOPL).

**Experiment with `define-datatype` and `cases` thoroughly because we will
be building our interpreter using these two expressions.**

### IMPORTANT:
The test cases will not compile until you implement your datatype using
`define-datatype` and use the naming convention discussed in class and in the textbook.
Currently, all tests are simply commented out, uncomment them and try running.

## You will get a 30 point penalty right off the bat if you submit homework for which the test cases don't compile.

## [20p] 1. File revisited

Recall in homework 4, the <file> data-type is defined as:

```
<file> ::= "ext-dir" <file>  <file>       "extend-directory"
          | "empty-dir" string            "empty-directory"
          | "regular" string number       "regular-file"
```

And you have tried to implment the interface manually by procedural-based
approach. Now:

### 1.a

Reimplement the interface using define-datatype.

### 1.b

Implement the function: `(total-size file1)`

**Input:**
* `file:`a file, which can be either a directory or regular file, as given in the definition above

**Output:**
* a number that is equal to the sum of all the file sizes contained in file1, if it
is a directory, or simply the size of file1 if it is a regular file. You
can assume that if file1 is an empty directory, then its total-size is zero.

For this exercise you **are required** to use the `cases` expression in the
implementation of move. No copy-pasting the old implementation that used
the interface :) Implementing the interface in the first step served only
as practice. From here on out, when using `define-datatype`, we will no longer
write entire interfaces unless necessary. The `cases` expression will do the
job that was previously assigned to predicates and extractors.


## [30p] 2. Define-datatype implementation of environment

Recall the `<environment>` data type described in the lectures and in your textbook:

```
<environment> ::=
                   "empty-env"
                 | symbol value <environment> "extend-env"
```

* `(empty-env)` initializes an environment

* `(extend-env)` adds a new mapping from "symbol" to "value" in the old environment.
If the same symbol is added twice, then the previous mapping is not replaced, it is only shadowed.

* Additionaly, we write an extractor who's name deviates from the norm:`(apply-env env sym)`.
It will return the `value` mapped to `sym` in the given environment, or raise an exception if
no such mapping exists.

### 2.a [10p]
  Implement the environment using define-datatype.

### 2.b [20p]

Implement a procedure `(extend-env-wrapper sym val old-env final?)`
Compared to the constructor `extend-env` it has a boolean parameter `final?`
indicating whether or not the new mapping should be shadowable (overridable).

Whenever an environment is extended using the `final` variant, the symbol from its
corresponding mapping cannot be shadowed, any attempt to shadow the value of a `final`
symbol will result in an error.


## [50p] 3. Define-datatype, expression language

Consider the following data type:
```
<expression> ::=
                 number                                   "const-expression"
               | <expression> <expression> <expression>*  "add-expression"
               | <expression> <expression>                "sub-expression"
               | <expression> <expression> <expression>*  "mul-expression"
               | <expression> <expression>                "div-expression"
```

Each variant represents the arithmetic operation in its name. Const-expression simply
denotes a number.

`*` is the regular expression for "0 or more of whatever is before". In consequence,
`add-expression` and `mul-expression` can have two or more expressions as data. To represent
0 or more pieces of data in our variant we will use lists, see the test file for clarification.

### 3.a [10p]
Using define-datatype represent the `<expression>` data-type

Note:
Use the `(list-of predicate)` function. It take a predicate as a parameter and returns
a new predicate that given a list will tell you whether or not the initial predicate
holds for every element in the list. It is a curried function.


### 3.b [20p]
Implement a procedure `evaluate-expression` that given an `<expression>` datatype
computes the `racket` value of the expression (i.e. a number).

### 3.c [20p]
Implement a procedure `translate-to-racket` that given an `<expression>` datatype
will translate it to a racket/scheme list that can be evaluated using the `eval`
function.

The [`eval`](http://docs.racket-lang.org/guide/eval.html) function takes a list of symbols and evaluates them as if they
were a valid racket program.

```racket
> (define x 42)
> (eval '(+ x 3))
45
;eval wil interpret the symbols in the list as variables.

> (eval '(+ (- 100 50) 3 (* 2 5)))
63
```
