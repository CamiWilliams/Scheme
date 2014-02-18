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
  (cond 
    [(= (length lst) 0) #f]
    [(= (length lst) 1) (equal? (car lst) elem)]
    [else (if (< elem (list-ref lst (truncate (/ (length lst) 2))))
              (binary-search (take lst (truncate (/ (length lst) 2))) elem)
              (binary-search (list-tail lst (truncate (/ (length lst) 2))) elem) )]
    )
  )

;=============================== 02 Carpet =======================================
#|
I used the following terminology for this problem:

n = size of carpet

row = row number, 1 indexed.

k = size of the list of same symbols in the middle of any given row.
    for row 3 we have the list '(+ + +) so k = 3

k-list = the actual list from the definition of "k" 

padding = adding a symbol both at the head and tail of a list
          if you pad the list '(+ + +)
          once:  '(% + + + %)
          twice: '(+ % + + + % +)

 for a carpet with n = 3:        
(( + + + + + + + ) 1
 ( + % % % % % + ) 2
 ( + % + + + % + ) 3
 ( + % + % + % + ) 4
 ( + % + + + % + ) 5 <=> 3 this row is the same as the third one.
 ( + % % % % % + ) 6 <=> 2
 ( + + + + + + + ))7 <=> 1
In the solution we will use only the row numbers <= middle. Row
numbers > middle are transformed to their symmetrical counterparts.
|#

;this function calls the compute-carpet-row function 2*n + 1 times,
;and creates the final list from each row.
(define (carpet n)
  (define (carpet-helper n i carpet)
    (if (zero? i)
        carpet
        (carpet-helper n
                       (- i 1)
                       (cons (compute-carpet-row i n)
                             carpet))
        )
    )
  (carpet-helper n (size n) '())
  )

;the size of a row is 2*n + 1
(define (size n) (+ (* 2 n) 1))

;this function creates a list containing
;k symbols "sym"
;> (k-list 5 '+)
;'(+ + + + +)
(define (k-list k sym)
  (if (= k 0)
      '()
      (cons sym (k-list (- k 1) sym)))
  )

;this function will take either '% or '+ as
;input and always returns the opposing symbol
;to the one it received as input.
(define (next-symbol init-sym)
  (if (eq? init-sym '%) '+ '%))

;the symbol of the innermost k-list
(define (start-sym r n)
  (if (even? n)
      (if (odd? r) '% '+)
      (if (odd? r) '+ '%)))

(define (middle-row n) (+ n 1))

;for any given row number:
;  - it returns that row number if it is < middle
;  - it returns its symmetrical. From the previous
;    example, for row 6 it returns 2.
(define (get-symmetrical-row row-n carpet-size)
  (if (<= row-n (middle-row carpet-size))
      row-n
      (- (* (middle-row carpet-size) 2) row-n))
  )

(define (compute-carpet-row r n)
  ;letrec lets us define constants that can use
  ;each other in their definitions.
  (letrec
      ;we only deal with the unique sets of rows
      ((row (get-symmetrical-row r n))
       ;number of times we have to pad the middle 
       ;k-list with either '+ or '% both at the head
       ;and tail
       (n-of-paddings (compute-number-of-paddings row))
       ;the size of the k-list in the middle of the row
       (k (- (size n) (* n-of-paddings 2))))
    (if (= row 1)
        (k-list (size n) (start-sym row n))
        (pad-middle-k-list n-of-paddings
                           (k-list k (start-sym row n)))
        )
    )
  )

;take row 4 as an example:
;( + % + % + % + )
;the k-list is the middle '(%). That means that we
;have to pad that k-list 3 times to get our desired
;row.
(define (compute-number-of-paddings row) (- row 1))

;say we start out with the list '(+ + +) and
;number-of-paddings = 2
;first we build the list '(% + + + %)
;then in the next iteration we build '(+ % + + + % +)
(define (pad-middle-k-list number-of-paddings k-lst)
  (define (h i r-list)
    (if (zero? i)
        (flatten r-list)
        (h (- i 1) (list (next-symbol (car r-list))
                         r-list
                         (next-symbol (car r-list))))
        )
    )
  (h number-of-paddings k-lst)
  )

;=========================== 03 Y-Combinator =====================================
; Remember, no using define or letrec, refer to the README for more info.
(define-syntax-rule (fact x)
  ((lambda (f n)
     (f f n))
   (lambda (self n)
     (cond
       ((<= n 1) 1)
       (else
        (* n
           (self self (- n 1))))))
   x))

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

(define (fact-alt x)
  ((Y
    (lambda (self)
      (lambda (n)
        (cond
          ((<= n 1) 1)
          (else
           (*
            n
            (self (- n 1))
            )
           )
          )
        )
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
  (lambda (x)
    (or (s1 x) (s2 x))
    )
  )

;the set of all elements that are in both  in 's1' and 's2'
(define (intersection s1 s2)
  (lambda (x)
    (and (s1 x) (s2 x))
    )
  )

;the set of all elements that are in 's1', but that are not in 's2'
(define (diff s1 s2)
  (lambda (x)
    (and (s1 x) (not (s2 x)))
    )
  )

;returns the subset of s, for which the predicate 'predicate' is true.
(define (filter predicate s)
  (lambda (x)
    (and (predicate x) (s x))
    )
  )

;we assume that the sets can contain only numbers between 0 and bound
(define bound 100)
(define (generate-range) (range (+ bound 1)))

;returns whether or not the set contains at least an element for which
;the predicate is true.
(define (exists? predicate s)
  (define (test? x)
    (if (s x)
        (predicate x)
        #f
        )
    )
  (ormap test? (generate-range))
  )

;returns whether or not the predicate is true for all the elements
;of the set
(define (all? predicate s)
  (define (test? x)
    (if (s x)
        (predicate x)
        #t
        )
    )
  (andmap test? (generate-range))
  )

;returns a new set where "op" has been applied to all elements
(define (map-set op s)
  (lambda (x)
    (exists? (lambda (i)
               (equal? (op i) x))
             s)
    )
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
  (lambda (y)
    (if (= y key) 
        value
        NOT-FOUND)    
    )
  )

;a map containting all key-value pairs from the previous `map` plus
;the new (key,value) pair.
(define (add key value m)
  (lambda (y)
    (if (equal? y key) 
        value
        (m y))
    )
  )

;a map containing all previous (key,value) pairs except the one with the given
;given.
(define (remove key m)
  (lambda (y)
    (if (equal? y key)
        NOT-FOUND
        (m y))
    )
  )

;returns the set of keys in the given map. Use the functional sets defined
;previously. Again, you may assume that the keys range between 1 and 100.
(define (keys m)
  (lambda (y)
    (not (equal? NOT-FOUND (m y)))
    )
  )