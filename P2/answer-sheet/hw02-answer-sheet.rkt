#lang racket
(#%provide (all-defined))

#|
If there are any specific instructions for a problem, please read them carefully. Otherwise,
follow these general rules:
   - replace the 'UNIMPLEMENTED symbol with your solution
   - you are NOT allowed to change the names of any definition
   - you are NOT allowed to change the number of arguments of the pre-defined functions,
     but you can change the names of the arguments if you deem it necessary.
   - make sure that you submit an asnwer sheet that compiles! If you cannot write
     a correct solution at least make it compile, if you cannot make it compile then
     comment it out. In the latter case, make sure that the default definitions
     for the problem are still present. Otherwise you may incurr penalties to your
     score for this homework.
   - you may use any number of helper functions you deem necessary.
|#
;=========================== 01 Binary Search ====================================
(define (binary-search lst elem)
  'UNIMPLEMENTED
  )

;=============================== 02 Carpet =======================================
(define (carpet n)
  'UNIMPLEMENTED
  )

;=========================== 03 Y-Combinator =====================================
; Remember, no using define or letrec, refer to the README for more info.
(define-syntax-rule (fact x)
  'UNIMPLEMENTED
  )

; The canonical fixed point y-combinator function. The fact-alt function relies
; on this function, don't remove it.
(define (Y l)
  ((lambda (f) (f f))
   (lambda (f)
     (l
       (lambda (x)
         ((f f) x)
         )
       )
     )
   )
  )

; Do not use the fact syntax rule from above. It needs to be
; implemented using the y-combinator!

(define (fact-alt x)
  ((Y
     (lambda (UNIMPLEMENTED)
       'UNIMPLEMENTED
       )
     ) x))


;=========================== 04 Functional Set ===================================
(define (singleton-set x)
  (lambda (y)
    (equal? x y)
    )
  )
; An example of how this characteristic function behaves.
;> (define set-of-3 (singleton-set 3))
;> (set-of-3 3)
;#t
;> (set-of-3 4)
;#f


;the set of all elements that are in either 's1' or 's2'. Check the tests
; to see how to use these.
(define (union s1 s2)
  'UNIMPLEMENTED
  )

;the set of all elements that are in both  in 's1' and 's2'
(define (intersection s1 s2)
  'UNIMPLEMENTED
  )

;the set of all elements that are in 's1', but that are not in 's2'
(define (diff s1 s2)
  'UNIMPLEMENTED
  )

;returns the subset of s, for which the predicate 'predicate' is true.
(define (filter predicate s)
  'UNIMPLEMENTED
  )

;we assume that the sets can contain only numbers between 0 and bound
(define bound 100)

;returns whether or not the set contains at least an element for which
;the predicate is true.
(define (exists? predicate s)
  'UNIMPLEMENTED
  )

;returns whether or not the predicate is true for all the elements
;of the set
(define (all? predicate s)
  'UNIMPLEMENTED
  )

;returns a new set where "op" has been applied to all elements
(define (map-set op s)
  'UNIMPLEMENTED
  )

;just a sample predicate. Please do not remove. The tests will make use of it.
(define (prime? n)
  ;notice how this is a curried function :)
  (define (non-divisible? n)
    (lambda (i)
      (not (= (modulo n i) 0))))

  ;we know that the prime divisors of a number, n, can be found in the range
  ;2 -> sqrt(n)
  (define range-of-prime-divisors (cddr (range (+ (integer-sqrt n) 1))))

  (if (equal? n 1)
      #f
      (andmap (non-divisible? n) range-of-prime-divisors)
      )
  )

;=========================== 05 Functional Map ===================================
(define NOT-FOUND 'not-found)

(define (singleton-map key value)
  'UNIMPLEMENTED
  )

;a map containting all key-value pairs from the previous `map` plus
;the new (key,value) pair.
(define (add key value m)
  'UNIMPLEMENTED
  )

;a map containing all previous (key,value) pairs except the one with the given
;given.
(define (remove key m)
  'UNIMPLEMENTED
  )

;returns the set of keys in the given map. Use the functional sets defined
;previously. Again, you may assume that the keys range between 1 and 100.
(define (keys m)
  'UNIMPLEMENTED
  )
