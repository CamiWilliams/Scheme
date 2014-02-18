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
;======================================01=======================================
;((3 + 3) * 9)
;equal to 54
(define (p1-1)
  (* 9 
   (+ 3 3)
  )
)

;((6 * 9) / ((4 + 2) + (4 * 3)))
;equal to 3
(define (p1-2)
  (/
    (* 6 9)
    (+
     (+ 4 2)
     (* 4 3)
    )
  )
)

;(2* ((20 - (91 / 7)) * (45 - 42)))
;equal to 42
(define (p1-3)
  (* 2
   (*
    (- 45 42)
    (- 20
       (/ 91 7)
    )
   )
  )
)
;======================================02=======================================
;write your answer as a string; you do not need to write any special escape
;characters to distinguish new lines.
(define p2
  "Convert the algebraic expression from infix to prefix"
)
;======================================03=======================================
;;Write the definitions of x,y,z here:
(define x 2)
(define y 3)
(define z 4)
;======================================04=======================================
;you will need to have solved problem 3. The values x,y,z are not parameters
;of this function!
(define (p4)
  (cond
   ((= x y z) 0)
   ((and (> x z) (> y z)) (+ x y))
   ((and (> y x) (> z x)) (+ y z))
   ((and (> x y) (> z y)) (+ x z)) 
   (else 0)
  )
)

;======================================05=======================================
(define (p5)
  (cond
   ((= x y z) 0)
   ((and (< x z) (< y z)) (+ x y))
   ((and (< y x) (< z x)) (+ y z))
   ((and (< x y) (< z y)) (+ x z)) 
   (else 0)
   )
)

;======================================06=======================================
(define (p6)
  (equal? x y)
)

;======================================07=======================================
;same instructions as problem 02.
(define p7
  "The first is a variable, the second is a function"
)

;======================================08=======================================
(define p8
  "The single quote in Scheme defines a symbol, and signifies that what proceeds it is not to be evaluated."
)

;======================================09=======================================
(define p9
  "(Referenced from utexas.edu) Each time you call list, it creates a nw list. The arguments in list can be anything, and the results are what is put in a list. A quote has only one argument, and it is not evaluated- it is just a textual representation."
)

;======================================10=======================================
(define p10
  "(Referenced from stackoverflow.com) Strings can be different objects in different locations of memory, while two symbols can be identical. That being said, to compare strings, one has to compare every character separately while with a symbol, you can just use eq? to compare them."
)

;======================================11=======================================
;(4 2 6 9)
(define (p11-1)
  (list 4 2 6 9)  
)

;(spaceship
;  (name(serenity))
;  (class(firefly)))
(define (p11-2)
  (list 'spaceship (list 'name (list 'serenity)) (list 'class (list 'firefly)))
)

;(2 * ((20 - (91 / 7)) * (45 - 42)))
(define (p11-3)
    (list 2 '* (list (list 20 '- (list 91 '/ 7)) '* (list 45 '- 42)))
)

;======================================12=======================================
(define example '(a b c))

;(d a b c)
(define (p12-1 lst)
  (cons 'd lst)
)

;(a b d a b)
(define (p12-2 lst)
  (list (car lst) (car (cdr lst)) 'd (car lst) (car (cdr lst)))
)

;(b c d a)
(define (p12-3 lst)
  (list (car(cdr lst)) (car(cdr(cdr lst))) 'd (car lst))
)


;======================================13=======================================
(define p13
  "I did multiple tests comparing the two, and the most interesting one that I found was that eq? cannot be used to compare decimal numbers- it is always false. When I did some more research comparing the two, I found that Scheme stores non-integers differently from integers. That being said, eq? compares the object in memory (ie pointers), while equals? compares the actual data."
)

;======================================14=======================================
(define (create-error-msg sym val)
  (define str (string-append "This is a custom message. Symbol '" (symbol->string sym)))
  (define str2 (string-append str " was paired with value "))
  (define str3 (string-append str2 (number->string val)))
  (string-append str3 " instead of 42")
)
;======================================15=======================================
;No answer necessary
;======================================16=======================================
;;write two examples that fail *only* at runtime here:

(define (p16-example-1)
  (cdr 1 2) ;incorrect arguments not detected
)

(define (p16-example-2)
  (* + (/ (+ 1 2) 3)) ;too many operands, end of equation not detected (kind of like a stack overflow!)
)

;======================================17=======================================
(define (list-of-even-numbers? lst)
  (cond
   ((empty? lst) #t)
   ((and (integer? (car lst)) (= 0 (modulo (car lst) 2)))(list-of-even-numbers? (cdr lst))) 
   (else #f)
  )  
)
;======================================18=======================================
;;for n > 0
;Sn = 1/1 + 1/4 + 1/9 + 1/16 + ...
(define (series-a n)
  (define total (/ 1 (* n n)))
  (cond
   ((= n 1) total)
   (else (+ total (series-a (- n 1))))
  )  
)

;MY HELPER METHODS FOR PART B (Taken from class notes)
(define (fact n ) 
 (fact-iter n 1) 
) 

(define (fact-iter n prod) 
 (if 
 (= n 0) 
 prod 
 (fact-iter (- n 1) (* n prod) ) 
 ) 
) 
;====
;;for n >= 0
;Sn = 1 - 1/2 + 1/6 - 1/24 + ...
(define (series-b n)
  (define total (/ (expt -1 n) (fact (+ 1 n))))
  (cond
    ((= n 0) 1)
    (else (+ total (series-b (- n 1))))
  )
)