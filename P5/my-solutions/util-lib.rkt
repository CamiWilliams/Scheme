#lang racket
(#%provide (all-defined))

;This function takes 1 or more arguments and returns a string resulted
;from concatenating all string values corresponding to the arguments
;same behaviour as the ~a function, but portable.
(define (to-string s . los)
  (letrec
      ([lst (cons s los)]
       [lst-of-strings (map (lambda (s) (format "~a" s)) lst)])
    (foldr string-append "" lst-of-strings)
    )
  )
