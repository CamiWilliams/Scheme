#lang racket
(#%provide (all-defined))

(#%require rackunit)
(#%require "util-lib.rkt")
(#%require "test-infrastructure.rkt")

(#%require "hw02-answer-sheet.rkt")

;to run the tests, evaluate:
;>(test-all)

(define (test-all)
  ;or you can evaluate any of these seperately
  (test binary-search-test-suite)
  (test carpet-test-suite)
  (test fact-test-suite)
  (test fact-alt-test-suite)
  (test functional-set-suite)
  (test functional-map-suite)
  )

;=========================== 01 Binary Search ====================================
(define binary-search-test-suite
  (test-suite
   "Binary search."

   (test-case
    "Element in the middle of an odd length list"
    (check-equal? (binary-search '(1 2 3 4 5) 3) #t)
    )

   (test-case
    "Element to the left middle of an even list"
    (check-equal? (binary-search '(1 2 3 4 5 6) 3) #t)
    )

   (test-case
    "Element to the left middle of an even list"
    (check-equal? (binary-search '(1 2 3 4 5 6) 4) #t)
    )

   (test-case
    "Element to the right middle of an even list"
    (check-equal? (binary-search '(1 2 3 4 5 6) 4) #t)
    )

   (test-case
    "Element to the far right of a list"
    (check-equal? (binary-search '(1 2 3 4 5 6) 6) #t)
    )

   (test-case
    "Element to the far left of a list"
    (check-equal? (binary-search '(1 2 3 4 5 6) 1) #t)
    )

   (test-case
    "Element is only one in the list"
    (check-equal? (binary-search '(1) 1) #t)
    )

   (test-case
    "Element in an arbitrary position on the left side"
    (check-equal? (binary-search '(1 2 3 4 5 6 7 8 9 10 11) 3) #t)
    )

   (test-case
    "Element in an arbitrary position on the right side"
    (check-equal? (binary-search '(1 2 3 4 5 6 7 8 9 10 11) 9) #t)
    )

   (test-case
    "Element is not in the list"
    (check-equal? (binary-search '(1 2 3 4) 5) #f)
    )
   );end test-suite
  )
;=============================== 02 Carpet =======================================
(define carpet-test-suite
  (test-suite
   "carpet problem"

   (test-case
    "0 carpet"
    (check-equal?
     (carpet 0)
     '((%)))
    )

   (test-case
    "1 carpet"
    (check-equal?
     (carpet 1)
     '((+ + +)
       (+ % +)
       (+ + +))
     )
    )

   (test-case
    "2 carpet"
    (check-equal?
     (carpet 2)
     '((% % % % %)
       (% + + + %)
       (% + % + %)
       (% + + + %)
       (% % % % %))
     )
    )

   (test-case
    "3 carpet"
    (check-equal?
     (carpet 3)
     '((+ + + + + + +)
       (+ % % % % % +)
       (+ % + + + % +)
       (+ % + % + % +)
       (+ % + + + % +)
       (+ % % % % % +)
       (+ + + + + + +))
     )
    )

   )
  )

;============================ 03 Y-Combinator ====================================

(define fact-test-suite
  (test-suite
    "fact test"

    (test-case
      "0 fact"
      (check-equal?
        (fact 0)
        1
        )
      )

    (test-case
      "1 fact"
      (check-equal?
        (fact 1)
        1
        )
      )

    (test-case
      "2 fact"
      (check-equal?
        (fact 2)
        2
        )
      )

    (test-case
      "4 fact"
      (check-equal?
        (fact 4)
        24
        )
      )

    (test-case
      "6 fact"
      (check-equal?
        (fact 6)
        720
        )
      )

    )
  )

(define fact-alt-test-suite
  (test-suite
    "fact-alt test"

    (test-case
      "0 fact-alt"
      (check-equal?
        (fact-alt 0)
        1
        )
      )

    (test-case
      "1 fact-alt"
      (check-equal?
        (fact-alt 1)
        1
        )
      )

    (test-case
      "2 fact-alt"
      (check-equal?
        (fact-alt 2)
        2
        )
      )

    (test-case
      "4 fact-alt"
      (check-equal?
        (fact-alt 4)
        24
        )
      )

    (test-case
      "6 fact-alt"
      (check-equal?
        (fact-alt 6)
        720
        )
      )
    )
  )

;=========================== 04 Functional Set ===================================
(define functional-set-suite
  (test-suite
   "functional sets"
   (test-case
    "singleton-set test"

    (check-true ((singleton-set 1) 1) "set containing 1, given 1")
    (check-false ((singleton-set 1) 2) "set containing 1, given 2")
    )

   (test-case
    "union test"

    ;we will actually give names to our test data
    (define s1 (singleton-set 1))
    (define s2 (singleton-set 2))
    (define s1-2 (union s1 s2))

    (check-true (s1-2 1) "set containing 1 2, given 1")
    (check-true (s1-2 2) "set containing 1 2, given 2")
    (check-false (s1-2 3) "set containing 1 2, given 3")
    )

   (test-case
    "intersection test"

    ;we will actually give names to our test data
    (define s1 (singleton-set 1))
    (define s2 (singleton-set 2))
    (define s3 (singleton-set 3))
    (define s4 (singleton-set 4))

    (define s1-3 (union (union s1 s2) s3))
    (define s2-4 (union (union s2 s3) s4))

    ;this set will effectively contain elements 2,3
    (define s2-3 (intersection s1-3 s2-4))

    (check-true (s2-3 2) "set containing 2 3, given 2")
    (check-true (s2-3 3) "set containing 2 3, given 3")
    (check-false (s2-3 1) "set containing 2 3, given 1")
    (check-false (s2-3 4) "set containing 2 3, given 4")

    (check-false (s2-3 42) "set containing 2 3, given 42")
    )

   (test-case
    "diff test"

    ;we will actually give names to our test data
    (define s1 (singleton-set 1))
    (define s2 (singleton-set 2))
    (define s3 (singleton-set 3))
    (define s4 (singleton-set 4))

    (define s1-3 (union (union s1 s2) s3))
    (define s2-4 (union (union s2 s3) s4))

    ;this set will effectively contain only: 1
    (define sd-1 (diff s1-3 s2-4))

    (check-true (sd-1 1) "set containing 1, given 1")
    (check-false (sd-1 2) "set containing 1, given 2")
    (check-false (sd-1 3) "set containing 1, given 3")
    (check-false (sd-1 4) "set containing 1, given 4")

    (check-false (sd-1 42) "set containing 1, given 42")
    )

   (test-case
    "filter test"

    ;we will actually give names to our test data
    (define s1 (singleton-set 1))
    (define s2 (singleton-set 2))
    (define s3 (singleton-set 3))
    (define s4 (singleton-set 4))
    (define s7 (singleton-set 7))

    (define s1-7 (union (union (union (union s1 s2) s3) s4) s7))
    (define primes-set (filter prime? s1-7))

    (check-true (primes-set 2) "set containing primes, given 2")
    (check-true (primes-set 3) "set containing primes, given 3")
    (check-true (primes-set 7) "set containing primes, given 7")
    (check-false (primes-set 1) "set containing primes, given 1")
    (check-false (primes-set 4) "set containing primes, given 1")
    (check-false (primes-set 8) "set containing primes, given 8")
    )

   (test-case
    "exists? test"

    ;we will actually give names to our test data
    (define s4 (singleton-set 4))
    (define s6 (singleton-set 6))
    (define s7 (singleton-set 7))

    (define test-set (union (union s4 s6) s7))

    (check-true (exists? prime? test-set) "exists? a prime")

    (check-false (exists? string? test-set) "exists? a string")
    )

   (test-case
    "all? test"

    ;we will actually give names to our test data
    (define s3 (singleton-set 3))
    (define s7 (singleton-set 7))
    (define s13 (singleton-set 13))
    (define s4 (singleton-set 4))

    (define primes (union (union s3 s7) s13))
    (define mixed (union primes s4))

    (check-true (all? prime? primes) "all? primes in a primes only set")
    (check-false (all? prime? mixed) "all? primes in a mixed set")
    )

   (test-case
    "map-set test"

    ;we will actually give names to our test data
    (define s3 (singleton-set 3))
    (define s7 (singleton-set 7))
    (define s13 (singleton-set 13))

    (define primes (union (union s3 s7) s13))
    (define (add-forty-two x) (+ x 42))

    (define mapped-set (map-set add-forty-two primes))

    (check-true (mapped-set 45) "42+3 should be in the set")
    (check-true (mapped-set 49) "42+7 should be in the set")
    (check-true (mapped-set 55) "42+13 should be in the set")

    (check-false (mapped-set 3) "3, original value should not be in the new set")
    (check-false (mapped-set 7) "7, original value should not be in the new set")
    (check-false (mapped-set 13) "13, original value should not be in the new set")

    (check-false (mapped-set 42) "42, some random value should not be in the set")

    )

   )
  )

;=========================== 05 Functional Map ===================================
(define functional-map-suite
  (test-suite
   "functional maps"

   (test-case
    "singleton-map test"

    (define m (singleton-map 1 'one))

    (check-equal? (m 1) 'one "map containing 1->'one, given 1")
    (check-equal? (m 2) NOT-FOUND "map containing 1->'one, given 2")
    )

   (test-case
    "add to map test"

    (define m (singleton-map 1 'one))

    (define m-with-two (add 2 'two m))

    (check-equal? (m-with-two 1) 'one "map containing {(1->'one), (2->'two)}, given 1")
    (check-equal? (m-with-two 2) 'two "map containing {(1->'one), (2->'two)}, given 2")
    (check-equal? (m-with-two 3) NOT-FOUND "map containing {(1->'one), (2->'two)}, given 3")
    )

   (test-case
    "remove from map test"

    (define m (singleton-map 1 'one))
    (define m-with-two (add 2 'two m))
    (define m-without-two (remove 2 m-with-two))

    (check-equal? (m-without-two 1) 'one "map containing {(1->'one), (2->'two)} - {(2->'two)}, given 1")
    (check-equal? (m-without-two 2) NOT-FOUND "map containing {(1->'one), (2->'two)} - {(2->'two)}, given 2")
    (check-equal? (m-without-two 3) NOT-FOUND "map containing {(1->'one), (2->'two)} - {(2->'two)}, given 3")
    )

   (test-case
    "keys of map test"

    (define m (singleton-map 1 'one))
    (define m-with-two (add 2 'two m))

    (define ks (keys m-with-two))

    (check-true (ks 1) "set of keys {1, 2}, given 1")
    (check-true (ks 2) "set of keys {1, 2}, given 2")
    (check-false (ks 3) "set of keys {1, 2}, given 3")
    )
   )
  )
