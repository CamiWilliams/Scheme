#lang racket

(#%require rackunit)
(#%require "test-infrastructure.rkt")

(#%require "hw03-answer-sheet.rkt")


(define (test-all)
  (test p1-balanced?-suite)
  (test p2-a-foldl-suite)
  (test p2-b-foldr-suite)
  (test p3-andmap-suite)
  (test p4-filter-suite)
  (test p5-map-reduce-suite)
  (test p6-series-revisited-suite)
  (test p7-matrix-to-vector-suite)
  (test p8-square-primes-suite)
  (test p9-currying-suite)
  (test p10-scala-for-suite)
  (test p11-implicit-currying-suite)
  )

;problem 1
(define p1-balanced?-suite
  (test-suite
   "parenthesis balancing"
   
   (test-case
    "()"
    (check-true
     (balanced? "()")
     )
    )
   
   (test-case
    "("
    (check-false
     (balanced? "(")
     ))
   
   (test-case
    ")"
    (check-false
     (balanced? ")")
     )
    )
   
   (test-case
    "nested parentheses, balanced"
    (check-true
     (balanced? "(())")
     )
    )
   
   (test-case
    "even more nested parentheses, balanced"
    (check-true
     (balanced? "((()))")
     )
    )
   
   (test-case
    "counting is not enough, unbalanced"
    (check-false
     (balanced? "())(")
     )
    )
   
   (test-case
    "contains irrelevant characters, balanced"
    (check-true
     (balanced? "(balanced? (stuff))")
     
     )
    )
   
   (test-case
    "contains irrelevant characters, unbalanced"
    (check-false
     (balanced? "(balanced? (stuff) probably not") 
     )
    )
   
   )
  )

;problem 2
(define p2-a-foldl-suite
  (test-suite
   "fold left"
   
   (test-case
    "foldl with addition"
    (check-equal?
     (foldl-342 + 0 '(1 2 3 4))
     10
     )
    )
   
   (test-case
    "foldl over an empty list"
    (check-equal?
     (foldl-342 + 0 '())
     0
     )
    )
   
   (test-case
    "foldl over an empty list with zero element = 42"
    (check-equal?
     (foldl-342 + 42 '())
     42
     )
    )
   
   (test-case     
    "foldl over strings"   
    (check-equal?
     (foldl-342 string-append "" (list "!!!" "42"  "is " "answer " "the " ))
     "the answer is 42!!!"
     )
    )
   
   (test-case
    "foldl with subtraction in order list"
    (check-equal?
     (foldl-342 - 0 '(1 2 3 4))
     2
     )
    )
   (test-case
    "foldl with subtraction reverse order list"
    (check-equal?
     (foldl-342 - 0 '(4 3 2 1))
     -2
     )
    )
   
   )
  )

(define p2-b-foldr-suite
  (test-suite
   "fold right"
   
   (test-case 
    "foldr with addition"
    (check-equal?
     (foldr-342 + 0 '(1 2 3 4))
     10
     )
    )
   
   (test-case
    "foldr with addition"
    (check-equal?
     (foldr-342 + 0 '())
     0
     "foldr over an empty list"
     )
    )
   
   (test-case
    "foldr over an empty list with zero element = 42"
    (check-equal?
     (foldr-342 + 42 '())
     42
     
     )
    )
   
   (test-case
    "foldr over strings"
    (check-equal?
     (foldr-342 string-append "" (list "the " "answer " "is " "42" "!!!"))
     "the answer is 42!!!"
     )
    )
   
   (test-case
    "foldr with subtraction in order list"
    (check-equal?
     (foldr-342 - 0 '(1 2 3 4))
     -2
     )
    )
   
   (test-case
    "foldr with subtraction reverse order list"
    (check-equal?
     (foldr-342 - 0 '(4 3 2 1))
     2  
     )
    )
   
   )
  )

;problem 3
(define p3-andmap-suite
  (test-suite
   "andmap"
   
   (test-case
    "list containing only odd numbers"
    (check-equal?
     (andmap-342 odd? '(1 3 5))
     #t
     )
    )
   
   (test-case
    "list of odds containing one even number"
    (check-equal?
     (andmap-342 odd? '(1 3 6))
     #f
     )
    )
   
   (test-case
    "empty list"
    (check-equal?
     (andmap-342 odd? '())
     #t
     )
    )
   
   )
  )

;problem 4
(define p4-filter-suite
  (test-suite
   "filter"
   
   (test-case
    "filter odds"
    (check-equal?
     (filter-342 odd? '(1 2 3 4 5 6 7 8 9 10))
     '(1 3 5 7 9)
     )
    )
   
   (test-case
    "filter numbers"
    (check-equal?
     (filter-342 number? '(42 'not-a-number "not-a-number"))
     '(42)
     )
    )
   
   (test-case
    "no elements fit the filter"
    (check-equal?
     (filter-342 number? '( 'not-a-number "not-a-number"))
     '()
     )
    )
   )
  )

;problem 5
(define add-forty-two
  (lambda (x) (+ x 42)))

(define p5-map-reduce-suite
  (test-suite
   "map reduce"
   
   (test-case
    "we add 42 to each number then add them together"
    (check-equal?
     (map-reduce add-forty-two + 0 '(0 1 2))
     129
     )
    )
   
   (test-case
    "map reduce over an empty list with zero element 0"
    (check-equal?
     (map-reduce add-forty-two + 0 '())
     0
     )
    )
   
   (test-case
    "map reduce over an empty list with zero element = 42"
    (check-equal?
     (map-reduce add-forty-two + 42 '())
     42
     )
    )
   )
  )

;problem 6
(define p6-series-revisited-suite
  (test-suite
   "revisiting series: Sn = 1 - 1/2 + 1/6 - 1/24 + ..."
   
   (test-case 
    "test 0"
    (check-equal?
     (series 0)
     1
     )
    )
   
   (test-case
    "test 1"
    (check-equal?
     (series 1)
     1/2
     )
    )
   
   (test-case
    "test 2"
    (check-equal?
     (series 2)
     2/3
     
     )
    )
   
   (test-case
    "test 3"
    (check-equal?
     (series 3)
     5/8
     )
    )
   (test-case
    "test 4"
    (check-equal?
     (series 4)
     19/30
     )
    )
   
   (test-case
    "test 5"
    (check-equal?
     (series 5)
     91/144
     )
    )
   
   )
  )

;problem 7
(define n-matrix
  '((1 2 3 4)
    (5 6 7 8)
    (9 0 1 2))
  )

(define str-matrix
  '(("a" "c" "e")
    ("b" "d" "f"))
  )

(define p7-matrix-to-vector-suite
  (test-suite
   "matrix to vector"
   
   (test-case
    "reduction with addition"
    (check-equal?
     (matrix-to-vector + n-matrix)
     '(15 8 11 14)
     )
    )
   
   (test-case
    "reduction with string concatenation"
    (check-equal?
     (matrix-to-vector string-append str-matrix)
     '("ab" "cd" "ef")
     )
    )
   )
  )

;problem 8
(define p8-square-primes-suite
  (test-suite
   "square primes"
   
   (test-case
    "square primes in an empty-list"
    (check-equal?
     (square-primes '())
     '()
     )
    )
   
   (test-case
    "square primes in a list containing only primes"
    (check-equal?
     (square-primes '(2 3 7 3 13))
     '(4 9 49 9 169)
     )
    )
   
   (test-case
    "square primes in a list containing no primes"
    (check-equal?
     (square-primes '(4 6 8))
     '()
     )
    )
   
   (test-case
    "square primes in a a list containing both primes and non-primes"
    (check-equal?
     (square-primes '(2 3 42 7 8 3 13))
     '(4 9 49 9 169)
     )
    )
   )
  )

;problem 9
(define p9-currying-suite
  (test-suite
   "currying"
   
   (test-case
    "test 1"
    (check-equal?
     ((add-two-numbers 2) 3)
     5
     )
    )
   
   (test-case
    "test 2"
    (check-equal?
     ((add-two-numbers 1) 2)
     3
     )
    )
   )
  )

;problem 10
(define p10-scala-for-suite
  (test-suite
   "scala for"
   
   (test-case
    "loop over empty list"
    (check-equal?
     (for {i <- '()} yield (+ i 42))
     '()
     )
    )
   
   (test-case
    "add 42 to the list"
    (check-equal?
     (for {a <- '(0 1 2 3)} yield (+ a 42))
     '(42 43 44 45)
     )
    )
   
   (test-case
    "ignore looping variable since it is never used in the body of the for."
    (check-equal?
     (for {to-ignore <- '(0 1 2 3)} yield 42)
     '(42 42 42 42)
     )
    )
   )
  )


;problem 11
(define ratio (partially-applied-fun (numerator denominator) (/ numerator denominator)))
(define p11-implicit-currying-suite
  (test-suite
   "implicit currying suite"
   
   (test-case
    "applied first argument"
    
    ;this should be a function that divides 42 by
    ;the supplied parameter
    (define num-42 (ratio 42 '_))
    
    (check-equal? (num-42 42) 1)
    (check-equal? (num-42 21) 2)
    )
   
   (test-case
    "applied second argument"
    
    ;this should be a function that divides the
    ;supplied paramter by 42.
    (define denom-42 (ratio '_ 42))
    
    (check-equal? (denom-42 42) 1)
    (check-equal? (denom-42 84) 2)
    )
   
   (test-case
    "applied no argument. This should behave like the original function."
    
    ;this should be a function that divides the
    ;supplied paramter by 42.
    (define iden (ratio '_ '_))
    
    (check-equal? (iden 42 42) 1)
    (check-equal? (iden 84 42) 2)
    )
   
   )
  )