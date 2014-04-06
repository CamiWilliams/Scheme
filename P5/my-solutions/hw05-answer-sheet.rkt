#lang racket
(#%provide (all-defined))
(#%require (lib "eopl.ss" "eopl"))
(#%require "util-lib.rkt")

#|
IMPORTANT: Don't forget to make sure that the uncommented version of your tests
compiles before submitting.
|#
;=======================================01======================================
;1.a
(define (invalid-args-msg fun-name-as-string
                          expected-value-type-as-predicate-string
                          received)
  (string-append "Invalid arguments in: " fun-name-as-string " --- "
                 "expected: " expected-value-type-as-predicate-string " --- "
                 "received: " (to-string received)
                 )
)

;You can compare the contents of this answer sheet with the answer sheet of the
;previous two homeworks to infer what is generated automatically by define-datatype.

;<file> ::= "ext-dir" <file>  <file>       "extend-directory"
;          | "empty-dir" string            "empty-directory"
;          | "regular" string number       "regular-file"


;DEFINING DATA-TYPE
(define-datatype file file?
  (extend-directory (f1 file?) (f2 file?))
  (empty-directory (dirname string?))
  (regular-file (filename string?) (nbytes number?))
)


(define (regular-file? f)
  (cases file f
     (regular-file (filename nbytes)
          #t
        )
       (else #f)
     )
  )

(define (empty-directory? f)
  (cases file f
     (empty-directory (dirname)
          #t
        )
       (else #f)
     )
)

(define (extend-directory? f)
  (cases file f
     (extend-directory (f1 f2)
          #t
        )
       (else #f)
     )
)

(define (regular-file->name f)
  (cond
    ((regular-file? f)
     (cases file f
       (regular-file (filename nbytes)
          filename
        )
       (else raise invalid-args-msg)
     ))
    ((empty-directory? f) raise (invalid-args-msg "regular-file->name" "regular-file?" "empty-directory"))
    (else (invalid-args-msg "regular-file->name" "regular-file?" "extend-directory"))
    )
)

(define (regular-file->bytes f)
  (cond
    ((regular-file? f)
     (cases file f
       (regular-file (filename nbytes)
          nbytes
        )
       (else raise invalid-args-msg)
     ))
    ((empty-directory? f) raise (invalid-args-msg "regular-file->bytes" "regular-file?" "empty-directory"))
    (else (invalid-args-msg "regular-file->nbytes" "regular-file?" "extend-directory"))
    )
)

(define (empty-directory->name f)
  (cond
    ((empty-directory? f)
      (cases file f
       (empty-directory (dirname)
          dirname
        )
       (else raise invalid-args-msg)
     ))
    ((regular-file? f) raise (invalid-args-msg "empty-directory->name" "empty-directory?" "regular-file"))
    (else (invalid-args-msg "empty-directory->name" "empty-directory?" "extend-directory"))
  )
)


(define (extend-directory->f-1 f)
   (cond
    ((extend-directory? f)
      (cases file f
       (extend-directory (f1 f2)
          f1
        )
       (else raise invalid-args-msg)
     ))
  ((regular-file? f) raise (invalid-args-msg "extend-directory->f-1" "extend-directory?" "regular-file"))
  (else raise (invalid-args-msg "extend-directory->f-1" "extend-directory?" "empty-directory"))
  )
)


(define (extend-directory->f-2 f)
   (cond
    ((extend-directory? f)
      (cases file f
        (extend-directory (f1 f2)
          f2
        )
       (else raise invalid-args-msg)
     ))
  ((regular-file? f) raise (invalid-args-msg "extend-directory->f-2" "extend-directory?" "regular-file"))
  (else raise (invalid-args-msg "extend-directory->f-2" "extend-directory?" "empty-directory"))
   
  )
)



;;1.b ===================================
(define (total-size file1)
  (cases file file1
     (regular-file (filename nbytes)
          nbytes
        )
    (extend-directory (f1 f2)
         ( + (total-size f1) (total-size f2))
        )
     (else 0)
   )
)
;=======================================02======================================
;<environment> ::=
;                   "empty-env"
;                 | symbol value <environment> "extend-env"

;WITH HELP FROM NOTES

;2.a
(define (exception-no-binding-msg sym)
  (string-append "No binding for '" (~a sym))
  )

;
(define-datatype environment environment?
  (empty-env) 
  (extend-env (var symbol?)(val number?)(env environment?))
  (final-env (var symbol?) (val number?) (env environment?) (f boolean?))
  )

(define (apply-env env search-sym)
  (cases environment env 
     (empty-env ()
      (exception-no-binding-msg search-sym)
      ) 
     (extend-env (saved-var saved-val saved-env) 
            (if (eqv? search-sym saved-var) 
                saved-val 
                (apply-env saved-env search-sym)
             )
       )
    (final-env (saved-var saved-val saved-env f) 
            (if (eqv? search-sym saved-var) 
                saved-val 
                (apply-env saved-env search-sym)
             )
       )
     (else (exception-no-binding-msg search-sym))
     )
  )

;==========
;2.b
(define (exception-sym-final-msg sym)
  (string-append "Symbol '" (~a sym) " is final and cannot be overriden.")
  )

;It is prefered to give meaningfull names to marker values.
;In the tests we will be using these two values to invoke
;the extend-env-wrapper function
(define FINAL #t)
(define NON-FINAL #f)

(define (final-env? e)
(cases environment e
     (final-env (saved-var saved-val saved-env f)
          #t
        )
       (else #f)
     )
  )

(define (empty-env? e)
  (cases environment e
     (empty-env ()
          #t
        )
       (else #f)
     )
)

(define (extend-env-wrapper sym val old-env final?)
  (if (ef? old-env sym)
      (exception-sym-final-msg sym)
      (if (equal? final? #t)
          (final-env sym val old-env final?)
          (extend-env sym val old-env)
          )
    )
  )

(define (ef? env sym)
  (cases environment env
    (extend-env (sym1 value env1) 
       (if (equal? sym sym1)
           #f
           (ef? env1 sym)
        ))
    (final-env (sym1 value env1 f) 
       (if (equal? sym sym1)
           #t
           (ef? env1 sym)
           ))
    (else #f)
    )
  )

;=======================================03======================================
;<expression> ::=
;                 number                                   "const-expression"
;               | <expression> <expression> <expression>*  "add-expression"
;               | <expression> <expression>                "sub-expression"
;               | <expression> <expression> <expression>*  "mul-expression"
;               | <expression> <expression>                "div-expression"



;3.a.
(define-datatype expression expression?
  (const-expression (num number?))
  (add-expression (exp1 expression?) (exp2 expression?) (exp3 list?))
  (sub-expression (exp1 expression?) (exp2 expression?))
  (mul-expression (exp1 expression?) (exp2 expression?) (exp3 list?))
  (div-expression (exp1 expression?) (exp2 expression?))
  )

(define (const-expression? e)
  (cases expression e
     (const-expression (num)
          #t
        )
       (else #f)
     )
)

(define (const-expression->num e)
  (cases expression e
        (const-expression (num)
          num
        )
       (else raise "")
     )
  )

(define (add-expression? e)
  (cases expression e
     (add-expression (e1 e2 e3)
          #t
        )
       (else #f)
     )
)

(define (add-expression->e1 e)
  (cases expression e
        (add-expression (e1 e2 e3)
          e1
        )
       (else raise "")
     )
  )

(define (add-expression->e2 e)
  (cases expression e
        (add-expression (e1 e2 e3)
          e2
        )
       (else raise "")
     )
  )

(define (add-expression->e3 e)
  (cases expression e
        (add-expression (e1 e2 e3)
          e3
        )
       (else raise "")
     )
  )

(define (sub-expression? e)
  (cases expression e
     (sub-expression (e1 e2)
          #t
        )
       (else #f)
     )
)

(define (sub-expression->e1 e)
  (cases expression e
        (sub-expression (e1 e2)
          e1
        )
       (else raise "")
     )
  )

(define (sub-expression->e2 e)
  (cases expression e
        (sub-expression (e1 e2)
          e2
        )
       (else raise "")
     )
  )


(define (mul-expression? e)
  (cases expression e
     (mul-expression (e1 e2 e3)
          #t
        )
       (else #f)
     )
)

(define (mul-expression->e1 e)
  (cases expression e
        (mul-expression (e1 e2 e3)
          e1
        )
       (else raise "")
     )
  )

(define (mul-expression->e2 e)
  (cases expression e
        (mul-expression (e1 e2 e3)
          e2
        )
       (else raise "")
     )
  )

(define (mul-expression->e3 e)
  (cases expression e
        (mul-expression (e1 e2 e3)
          e3
        )
       (else raise "")
     )
  )

(define (div-expression? e)
  (cases expression e
     (div-expression (e1 e2)
          #t
        )
       (else #f)
     )
)

(define (div-expression->e1 e)
  (cases expression e
        (div-expression (e1 e2)
          e1
        )
       (else raise "")
     )
  )

(define (div-expression->e2 e)
  (cases expression e
        (div-expression (e1 e2)
          e2
        )
       (else raise "")
     )
  )

;.3.b
(define (add-evl e)
  (cond
    ((expression? e) (evaluate-expression e))
    ((null? e) 0)
    (else
     (+ (evaluate-expression (car e)) (add-evl (cdr e)))
     )
    )
  )
(define (mul-evl e)
  (cond
    ((expression? e) (evaluate-expression e))
    ((null? e) 1)
    (else
     (* (evaluate-expression (car e)) (mul-evl (cdr e)))
     )
    )
  )

(define (evaluate-expression expr)
  (cond
    ((number? expr) expr)
    ((const-expression? expr) (const-expression->num expr))
    ((add-expression? expr)
     (+ (evaluate-expression (add-expression->e1 expr)) (evaluate-expression (add-expression->e2 expr)) (add-evl (add-expression->e3 expr)))
      )
    ((sub-expression? expr)
     (- (evaluate-expression (sub-expression->e1 expr)) (evaluate-expression (sub-expression->e2 expr)))
        )
    ((mul-expression? expr)
     (* (evaluate-expression (mul-expression->e1 expr)) (evaluate-expression (mul-expression->e2 expr)) (mul-evl (mul-expression->e3 expr)))
      )
    (else 
     (/ (evaluate-expression (div-expression->e1 expr)) (evaluate-expression (div-expression->e2 expr)))
     )
    )
  )

;3.c
#|
the "eval" function takes a list of symbols and evaluates them as if they
were a valid racket program.

> (define x 42)
> (eval '(+ x 3))
42

> (eval '(+ (- 100 50) 3 (* 2 5)))
63

Your translate-to-racket will have to return a list such that eval will
yield the correct value of the expression.
|#

(define (sub-evl e)
  (cond
    ((expression? e) (evaluate-expression e))
    ((null? e) 0)
    (else
     (- (evaluate-expression (car e)) (sub-evl (cdr e)))
     )
    )
  )
(define (div-evl e)
  (cond
    ((expression? e) (evaluate-expression e))
    ((null? e) 1)
    (else
     (/ (evaluate-expression (car e)) (div-evl (cdr e)))
     )
    )
  )

(define (translate-to-racket expr)
   (cond    
     ((expression? expr) (evaluate-expression expr))
     ((list? expr)
      (cond
        ((eq? (car expr) +)
          (+ (translate-to-racket (car (cdr exp))) (translate-to-racket (cdr exp)))
        )
        ((eq? (car expr) -)
         (- (translate-to-racket (car (cdr exp))) (translate-to-racket (cdr exp)))
        )
        ((eq? (car expr) *)
          (* (translate-to-racket (car (cdr exp))) (translate-to-racket (cdr exp)))
         )
        ((eq? (car expr) /)
          (/ (translate-to-racket (car (cdr exp))) (translate-to-racket (cdr exp)))
        )
       )
      )
     (else expr)
     )
  )
