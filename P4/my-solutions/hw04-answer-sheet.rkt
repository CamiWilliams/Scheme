#lang racket
(#%provide (all-defined))

;======================================01.a=======================================
;DONE!!!!!!
(define-syntax-rule (seq expr1 expr2)
  (
   (lambda ()
     expr1
     expr2
     )
   )
  )

;======================================01.b=======================================
;DONE!!!!!
(define-syntax-rule (while condition body)
  (let loop ()
    (if condition 
        (begin 
          body 
          (loop)
          )
       0)
    )
  )
;======================================02=======================================

;creates an empty-tree DONE!!!!
(define (empty-tree)
  '()
  )

;returns true or false if tree is empty DONE!!!!
(define (empty-tree? tree)
  (if (equal? (empty-tree) tree)
      #t
      #f
      )
  )


;creates a tree with only one node DONE!!!!
(define (bstree root)
 (list root '() '())
  )

;returns the root of the given tree DONE!!!!
(define (tree->root tree)
  (car tree)
  )

;returns the left subtree DONE!!!!
(define (tree->left tree)
    (car (cdr tree))  
  )

;returns the right subtree DONE!!!!
(define (tree->right tree)
    (car (cdr (cdr tree)))
  )

;Helper
(define (left-insert n t)
  (list (car t) (insert-tree n (car (cdr t))) (car (cdr (cdr t))))
  )

;Helper
(define (right-insert n t)
  (list (car t) (car (cdr t)) (insert-tree n (car (cdr (cdr t)))))
)


;inserts a node with value n into the tree while still maintaining the binary tree's properties
;DONE!!!!
(define (insert-tree n t)
  (cond 
    ((empty-tree? t) (bstree n))
    ((> n (tree->root t)) (right-insert n t))
    (else (left-insert n t))
    )
 )

;Helper
(define (tlist tree fin)
  (cond 
    ((null? tree) fin)
    ((null? (car tree)) (tlist (cdr tree) fin))
    (else (append (list (car tree) fin)))
      )
)
;returns a list containing all values of the tree in sorted order DONE!!!!
(define (tree->list tree)
  (append (append (tlist (cdr (tree->left tree)) (list (car (tree->left tree)))) (list(tree->root tree))) (tlist (cdr (tree->right tree)) (list (car (tree->right tree)))))
  )

;======================================03=======================================
;you should use this function to create the error messages.
(define (invalid-args-msg fun-name-as-string
                          expected-value-type-as-predicate-string
                          received)
  (string-append "Invalid arguments in: " fun-name-as-string " --- "
                 "expected: " expected-value-type-as-predicate-string " --- "
                 "received: " (~a received)
                 )
  )

;DONE!!!!
(define (regular-file name n)
  (if (or (not (string? name)) (not (number? n)))
      (invalid-args-msg "regular-file" "string? number?" (string-append (~a name) " " (~a n)))
      (lambda(arg)
        (if (equal? arg "name")
            name 
            (if (equal? arg "bytes")
                n
                (if (equal? arg "type")
                    'regular-file
                    ""
                    )
                )
            )
        )
      )
)

;DONE!!!!
(define (empty-directory name)
  (if (not (string? name))
      (invalid-args-msg "empty-dir" "string?" (~a name))
      (lambda (arg)
        (if (equal? arg "name")
            name
            (if (equal? arg "type")
                'empty-directory
                ""
                )
            )
        )
      )  
)

;DONE!!!!
(define (extend-directory f-1 f-2)
  (lambda (arg)
    (if (equal? arg "f-1")
        f-1
        (if (equal? arg "f-2")
            f-2
            (if (equal? arg "type")
                'extend-directory
                ""
                )
            )
        )
    )  
)

;DONE!!!!
(define (regular-file? f)
  (if (string? f)
      #f
      (if (equal? (f "type") 'regular-file)
          #t
          #f
          )
      ) 
)

;DONE!!!!
(define (empty-directory? f)
  (if (string? f)
      #f
      (if (equal? (f "type") 'empty-directory)
          #t
          #f
          )
      )  
)

;DONE!!!!
(define (extend-directory? f)
  (if (equal? (f "type") 'extend-directory)
      (and
       (or (empty-directory? (f "f-1")) (regular-file? (f "f-1")) (extend-directory? (f "f-1"))) 
       (or (empty-directory? (f "f-2")) (regular-file? (f "f-2")) (extend-directory? (f "f-2"))))
      #f
      )  
)

;DONE!!!!
(define (regular-file->name f)
  (if (regular-file? f)
      (f "name")
      (invalid-args-msg "regular-file->name" "regular-file?" (f "type"))
      )  
)

;DONE!!!!
(define (regular-file->bytes f)
  (if (regular-file? f)
      (f "bytes")
      (invalid-args-msg "regular-file->bytes" "regular-file?" (f "type"))
      )  
  )

;DONE!!!!
(define (empty-directory->name f)
  (if (empty-directory? f)
      (f "name")
      (invalid-args-msg "empty-directory->name" "empty-directory?" (f "type"))
      )  
  
  )

;;two extractors, one for each piece of data representing an extend-dir DONE!!!!
(define (extend-directory->f-1 f)
  (if (extend-directory? f)
      (f "f-1")
      (invalid-args-msg "extend-dir->f-1" "extend-dir?" (f "type"))
      )  
)

;DONE!!!!
(define (extend-directory->f-2 f)
  (if (extend-directory? f)
      (f "f-2")
      (invalid-args-msg "extend-dir->f-2" "extend-dir?" (f "type"))
      )  
)