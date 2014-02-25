# Spring 2014 ComS 342 Homework 04

# Deadline
Feb 24 2014, 9:00pm


# General description
This homework serves two purposes:

1. to further practice how to add new syntax into language, using `define-syntax-rule` provided by the Racket language.

2. to represent new data-types using procedural-based strategy, that is, to implement new data types as procedures.

## 1. Define syntax [50p]

The purpose of this exercise is two-fold: to give you more practice with syntax
definitions and to test your understanding of higher procedures a bit more. To that
end we will be imposing restrictions on what you are allowed to use to create these
syntax definitions.

### 1.a Seq [25p]

Using "define-syntax-rule" and only the lambda expression,
define a new syntax abstraction "seq" for sequence that runs two
expressions one after the other.

```racket
> (seq (print 1) (print 2))
12
> (define x 0)
> (seq (print x) (set! x (+ x 1)))
0
> x
1
> (seq (seq (display x) (set! x (+ x 1))) (display x))
12
```

### 1.b [25p]

Using `define-syntax-rule` and only the `lambda` expression,
`if` expression, and `let/letrec` expressions define a new syntax abstraction
`while` for while loops that takes two expressions `condition` and
`body` and runs the expression body while the condition remains true.
A transcript that documents some example usage of this expression is
given below:

```
> (define x 0)
> (while (< x 100) (set! x (+ x 1)))
0
> x
100

> (while (< x 105) (seq (print " * ") (set! x (+ x 1))))
 *  *  *  *  * 0
```  

##### Note:
`body` and `condition` can be **any** arbitrarily complex
expression with an arbitrarily high level of nesting.

# BNF grammar recap.

Recall that we can describe the list data-type using a regular grammar:
```
<list> ::=  null
          | <data> <list>
          
<data> ::=  number
          | string
          | procedure
          | symbol
          | <list>
```       
In plain english: a list can be either `null` or it can be a pair of: `data`
and another `list`. `data` can be either a number, a string, a procedure, a symbol,
or even a list. These parts of a larger data type are called `variants`. So
null is a variant of list.

The `|` symbol above means `or`, while the terms enclosed in angular brackets, `<>`, are called `non-terminals` and the ones that are not are called `terminals`.  

Non-terminals can be substituted for any valid value of that non-terminal.
For instance, take the second definition of the 
```
<list>: <data> <list>
```  
Here `<data>` could be substituted for the value `number`, and `<list>` for `null`.
Thus, effectively describing a list that contains only one number.  

# Procedural representation of data-types.

In this homework, for problems 2 and 3,  you will be using procedural-based strategy to  represent the data-types. Problem 3 is designed to further enhance your understanding of Data Abstractions.  
 
**A general rule** for procedural representation of datatypes is: instead of storing values in lists or other data types, you will be storing them in `closures`. Review the lecture notes and the attached file `hw04-closure-currying-illustrated.rkt` (this is the same example you got for homework 02) as a reminder of what closures are. Since currying is a closely related concept to closures, we discuss them together.
    

#### What procedural-based representation isn't:
- a list containing functions that simply return each individual element of the list
- if you use lists for anything but temporary computation, you are probably doing it wrong.


### 2. [25p] Binary search tree

A binary search tree can be easily described with the following grammar:
```
<tree> ::=  empty 
           | number <tree> <tree>
```
Although BNF grammar is very well suited to describe the structure of the data,
it is not suited to describe the constraints on the data.

For instance, we know that a binary search tree has the following properties:
- the left subtree of a node contains only nodes with keys less than the node's key.
- the right subtree of a node contains only nodes with keys greater than the node's key.
- there must be no duplicate nodes.
- the implication of the above is that in-order traversal yields a sorted sequence of keys  
  
Implement the following functions:
```racket
(empty-tree)
;creates an empty-tree

(empty-tree? tree) 
;returns #t or #f if the tree is empty or not

(bstree root) 
;creates a tree with only one node

(tree->root tree)
;returns the root of the given tree

(tree->left tree) 
;returns the left subtree

(tree->right tree) 
;returns the right subtree

(insert-tree n tree) 
;inserts a node with value n into the tree while still maintaining
;the binary tree's properties mentioned above.
     
(tree->list tree)
;return a list containing all the values of the tree in sorted order
```

Look at the test cases for examples. The functions are not independently tested,
i.e. `tree->left` depends on a correct implementation of `insert`. The reason for
this is that it provides independence from the internal representation of the
tree, the only constraint remaining is that the interface be self-consistent.


### 3. [25p] File 

The following data type describes a file under unix/linux: it can be either a regular file, or a directory 
```
<file> ::=  "ext-dir" <file>  <file>          "extend-directory"
          | "empty-dir" string                "empty-directory"
          | "regular" string number           "regular-file"
```

`"ext-dir`, `"empty-dir"` and `"regular"` are only markers that help differentiate between the three different kinds of files: a non-empty directory, an empty directory, and a regular file.

`"extend-directory"`, `"empty-directory"`, `"regular-file"` are symbolic names we use to identify each alternative production in the grammar, which may also be thought of as a `"variant"` of the `<file>` data type. The `"string"` clause in the `"empty-directory"` production refers to the name of a new empty directory, whereas the `"string"` clause in the `"regular-file"` production refers to the name of a new regular file. The `"number"` clause in `"regular-file"` production refers 
to the file size of a regular file.  

##### Note: 
The `"extend-directory"` production is the one that allows you to add another file, either a directory or a regular file, to a directory which is represented by the first `<file>` in the `"extend-directory"` production. With the `"empty-directory"` production, you always create a directory that is empty!

##### Your task: 
For each variant of the `<file>` datatype you should implement the following types
of functions:
- a constructor bearing the name of the variant. Constructors take any relevant data as parameters and return a new value of that type variant.
- a predicate with the name of the variant followed by a `"?"` mark
- extractors for each piece of data of the variants. e.g. we write one extractor for dir-file, regular-file and two for extend-dir.


##### Important!
Your implementation has to be based on **procedural representation** (check the most recent lecture notes inside blackboard if clarification is still needed for this concept)
     
The signatures of the above functions are already written down in the answer
sheet. You should take the time to see which procedure falls into which category
and infer their behavior from the test cases. We will be encountering this pattern
quite often in the future.

A few general rules to keep in mind:
- constructors throw exceptions when they receive invalid input
- predicates never throw exceptions, they either return `#t` or `#f`
- extractors throw exceptions when then receive invalid input










