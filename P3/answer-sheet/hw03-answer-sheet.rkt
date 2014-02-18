#lang racket
(#%provide (all-defined))

;problem 1 helper
(define (bal-help in out)
  (cond 
    ((null? in) (null? out))
    ((eq? (car in) '#\) ) 
     (if (null? out)
         #f
         (bal-help (cdr in) (cdr out))
         )
     )
    ((eq? (car in) '#\( ) (bal-help (cdr in) (cons '#\( out)))
    (else (bal-help (cdr in) out))
   )
  )

; problem 1  DONE!!!!!
(define (balanced? in)
  (bal-help (string->list in) (list))
  )

; problem 2-a DONE!!!!!
(define (foldl-342 op zero-el lst)
  (if (null? lst)
      zero-el
      (foldl-342 op (op (car lst) zero-el) (cdr lst))
      )
  )

;problem 2-b DONE!!!!!!!
(define (foldr-342 op zero-el lst)
  (if (null? lst)
      zero-el
      (op (car lst) (foldr-342 op zero-el (cdr lst)))
      ) 
  )

;problem 3 helper
(define (and-helper op lst works)
  (cond 
    ((null? lst) works)
    ((op (car lst)) (and-helper op (cdr lst) (append works (list (car lst)))))
    (else (and-helper op (cdr lst) works))
    )
  )

;problem 3 DONE!!!!!!!
(define (andmap-342 test-op lst)
  (define works (and-helper test-op lst (list)))
  (if (= (length works) (length lst))
      #t
      #f
      )
  )

;problem 4 helper
(define (filtered-helper op lst filtered)
  (cond 
    ((null? lst) filtered)
    ((op (car lst)) (filtered-helper op (cdr lst) (append filtered (list (car lst)))))
    (else (filtered-helper op (cdr lst) filtered))
    )
  )

;problem 4 DONE!!!!!
(define (filter-342 test-op lst)
  (filtered-helper test-op lst (list))
  )

;problem 5 helper1
(define (mh1 mop lst end)
  (if (null? lst) 
      end
      (mh1 mop (cdr lst) (append end (list (mop (car lst)))))
    )
  )

;problem 5 helper2
(define (mh2 rop zero-el lst num)
  (if (null? lst) 
      (rop num zero-el)
      (mh2 rop zero-el (cdr lst) (+ num (rop zero-el (car lst))))
    )
  )


;problem 5 DONE!!!!!
(define (map-reduce m-op r-op zero-el lst)
  (mh2 r-op zero-el (mh1 m-op lst (list)) 0)
  )

;problem 6 factorial from notes
(define (fact n)
     (fact-iter n 1) 
   
) 

(define (fact-iter n prod) 
 (if (= n 0) 
   prod 
   (fact-iter (- n 1) (* n prod) ) 
 ) 
) 

;problem 6 helper with map
(define (series-help n lst)
  (if (zero? n)
      lst
      (if (odd? n)
          (series-help (- n 1) (append lst (list (* -1 (map-reduce fact / (expt -1 n) (list (+ n 1)))))))
          (series-help (- n 1) (append lst (list (map-reduce fact / (expt -1 n) (list (+ n 1))))))
          )
      )
   )

;problem 6 DONE!!!!!
(define (series n)
  (if (zero? n)
      1
      (foldl-342 + 0 (series-help n '(1)))
      )
  )

;problem 7 helper1
(define (mat-help1 op mat end)
  (if (null? (cdr (car mat)))
      (append end (list (mat-help2 op (cdr mat) (caar mat))))
      (mat-help1 op (mat-help3 (cdr mat) (cdr (car mat))) (append end (list (mat-help2 op (cdr mat) (caar mat)))))
      )
  )
;problem 7 helper2
(define (mat-help2 op mat total)
  (if (null? (cdr mat))
      (op total (caar mat))
      (mat-help2 op (cdr mat) (op total (caar mat)))
    )
  )

;problem 7 helper3 
(define (mat-help3 mat small)
  (if (null? (cdr mat))
      (list small (cdr (car mat)))
      (cons small (mat-help3 (cdr mat) (cdr (car mat))))
      )
  )
  
;problem 7 DONE!!!!!!
(define (matrix-to-vector op mat)
  (mat-help1 op mat (list))
  )

;prime taken from hw2
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

;problem 8 helper
(define (square-helper lst squares)
  (cond 
    ((null? lst) squares)
    ((prime? (car lst)) (square-helper (cdr lst) (append squares (list (* (car lst) (car lst))))))
    (else (square-helper (cdr lst) squares))
    )
  )

;problem 8 DONE!!!!!
(define (square-primes list-of-numbers)
  (square-helper list-of-numbers (list))
  )


;problem 9 DONE!!!!!
(define (add-two-numbers x)
    (lambda (y)
      (+ x y)
    )
  )

;problem 10 helper
(define (rule-help lst var result end)
  (if (null? lst)
      end
      (rule-help (cdr lst) (set! var (car (cdr lst))) result (append end (result)))
      )
  )

;problem 10 DONE!!!!
(define-syntax-rule (for {var <- value-range} yield result)
  (map (lambda (var)
    result) value-range)
  )


;problem 11
(define-syntax-rule
  (partially-applied-fun (x y) body)
  (lambda (m n)
    (if (and (eq? m '_) (eq? n '_))
       (lambda (a b) (let* ([x a][y b]) body))
       
       (if (eq? m '_)
           (lambda (z) (let* ([x z][y n]) body))
           
           (if (eq? n '_)
               (lambda (z) (let* ([x m][y z]) body))
               (lambda () (let* ([x m][y n]) body))
             )
          )
       )
    )      
  )
