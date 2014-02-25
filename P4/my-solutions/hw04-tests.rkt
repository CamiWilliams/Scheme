#lang racket
(#%provide (all-defined))

(#%require rackunit)
(#%require "test-infrastructure.rkt")
(#%require "hw04-answer-sheet.rkt")

(define (test-all)
  (test p1-a)
  (test p1-b)
  (test p2)
  (test p3)
  )

;======================================01=======================================
(define test-var-1 42)
(define p1-a
  (test-suite
   "seq test suite"

   (test-case
    "measure side effect and return value"
    (check-true
     (and (equal? (seq (set! test-var-1 'not-42) 342) 342)
          (equal? test-var-1 'not-42)))
    )

   (test-case
    "ignoring first expression"
    (check-equal?
     (seq 'to-be-ignored (* 5 6))
     30
     )
    )

   )
  )
;;======================
(define test-counter-1 0)

(define p1-b
  (test-suite
   "while"

   (test-case
    "loop and increment counter. While always returns 0"
    (check-true
     (and
      (equal? 0
              (while (< test-counter-1 100)
                     (set! test-counter-1 (+ test-counter-1 1))
                     )
              )
      (equal? test-counter-1 100)
      )
     )
    )

   (test-case
    "nested whiles"
    (let ([i 0] [j 0] [v #()])
      (while (< i 3)
             (begin
               ;;this condition is here to exemplify that it should be arbitrarily complex
               (while (and (< j 5) (= 1 1))
                      (begin
                        (set! j (+ j 1))
                        (set! v (vector-append v #(*)))
                        )
                      )
               (set! v (vector-append v #(/n)))
               (set! j 0)
               (set! i (+ i 1))
               )
             )
      (check-equal? v #(* * * * * /n * * * * * /n * * * * * /n))
      )
    )
   )
  )

;;=====================================================02=================================
(define p2
  (test-suite
   "binary search tree"

   (test-case
    "checks to see if an empty-tree is an empty tree"
    (check-true
     (empty-tree? (empty-tree))

     )
    )

   (test-case
    "is a bstree an empty-tree? no."
    (check-false
     (empty-tree? (bstree 42))
     )
    )

   (test-case
    "is a string an empty-tree? no."
    (check-false
     (empty-tree? "empty")
     )
    )

   (test-case
    "verifying proper construction"
    (check-equal?
     (tree->root (bstree 42))
     42
     )
    )

   (test-case
    "the left tree of a leaf bstree should be the empty-tree"
    (check-equal?
     (tree->left (bstree 42))
     (empty-tree)
     )
    )

   (test-case
    "the right tree of a leaf bstree should be the empty-tree"
    (check-equal?
     (tree->right (bstree 42))
     (empty-tree)
     )
    )

   (test-case
    "inserting a value into an empty tree"
    (check-equal?
     (insert-tree 8 (empty-tree))
     (bstree 8)
     )
    )

   (test-case
    "inserting a value into the left subtree"
    (check-equal?
     (tree->left (insert-tree 3 (bstree 8)))
     (bstree 3)
     )
    )

   (test-case
    "inserting a value into the right subtree"
    (check-equal?
     (tree->right (insert-tree 10 (bstree 8)))
     (bstree 10)
     )
    )

   (test-case
    "inserting a value into the left subtree at two level depth"
    (check-equal?
     (tree->left (tree->left (insert-tree 1 (insert-tree 3 (bstree 8)))))
     (bstree 1)
     )
    )

   (test-case
    "inserting a value into the right subtree at two level depth"
    (check-equal?
     (tree->right (tree->right (insert-tree 14 (insert-tree 10 (bstree 8)))))
     (bstree 14)
     )
    )

   (test-case
    "getting the sorted list"
    (check-equal? (tree->list (insert-tree 3 (insert-tree 10 (bstree 8))))
                  '(3 8 10)
                  )
    )

   ;;you might want to write more tests on your own.

   )
  )


;======================================03=======================================
(define p3
  (test-suite
   "file-a"

   (test-case
    "test 1. regular-file predicate test."
    (check-true
     (regular-file? (regular-file "CS342" 3))
     )
    )

   (test-case
    "exn 1. checking constructor exceptions."
    (342-check-exn
     (regular-file "file.txt" "not-a-number")
     "Invalid arguments in: regular-file --- expected: string? number? --- received: file.txt not-a-number")
    )

   (test-case
    "test 2. dir-file predicate test."
    (check-true
     (empty-directory? (empty-directory "CS342"))
     )
    )

   (test-case
    "exn 2. extend-directory constructor exception test."
    (342-check-exn
     (extend-directory "not-a-file" "not-a-file2")
     "Invalid arguments in: extend-dir --- expected: file? file? --- received: not-a-file not-a-file2")
    )

   (test-case
    "test 3. extend-dir predicate test"
    (check-true
     (extend-directory? (extend-directory (empty-directory "CS342") (regular-file "CS342-HW4.rkt" 200)) )
     )
    )

   (test-case
    "exn 3. regular-file constructor exception."
    (342-check-exn
     (regular-file 3 3)
     "Invalid arguments in: regular-file --- expected: string? number? --- received: 3 3")
    )

   (test-case
    "test 4. regular-file predicate test. False."
    (check-false
     (regular-file? (extend-directory (empty-directory "CS342") (regular-file "CS342-HW4.rkt" 200)))
     )
    )

   (test-case
    "test 5. extend-directory predicate test. true."
    (check-true
     (extend-directory? (extend-directory (empty-directory "CS342") (regular-file "CS342-HW4.rkt" 200)))
     )
    )

   (test-case
    "test 6. file predicate. False."
    (check-false
     (extend-directory? (empty-directory "CS342"))
     )
    )

   (test-case
    "test 7. regular-file->name extractor."
    (check-equal?
     (regular-file->name (regular-file "CS342-HW4.rkt" 200))
     "CS342-HW4.rkt"
     )
    )

   (test-case
    "test 8. regular-file->bytes extractor."
    (check-equal?
     (regular-file->bytes (regular-file "CS342-HW4.rkt" 200))
     200
     )
    )

   (test-case
    "test9 . emoty-directory->name extractor test."
    (check-equal?
     (empty-directory->name (empty-directory "CS342" ))
     "CS342"
     )
    )

   (test-case
    "test 10. extend-dir->f-1 extractor"
    (check-true
     (empty-directory?
       (extend-directory->f-1 (extend-directory (empty-directory "CS342") (regular-file "CS342-HW4.rkt" 200)) )
       )
     )
    )

   (test-case
    "test 11. extend-dir->f-2 extractor."
    (check-true
      (regular-file?
        (extend-directory->f-2 (extend-directory (empty-directory "CS342") (regular-file "CS342-HW4.rkt" 200)) )
        )
     )
    )

   (test-case
    "exn 4. regular-file->name exception test."
    (342-check-exn
     (regular-file->name (empty-directory "CS342"))
       "Invalid arguments in: regular-file->name --- expected: regular-file? --- received: empty-directory")
    )

   (test-case
    "exn 5. regular-file->bytes exception test."
    (342-check-exn
       (regular-file->bytes (empty-directory "CS342"))
       "Invalid arguments in: regular-file->bytes --- expected: regular-file? --- received: empty-directory")
    )

   (test-case
    "exn 6. empty-directory->name exception test"
    (342-check-exn
       (empty-directory->name (extend-directory (empty-directory "CS342") (regular-file "CS342-HW4.rkt" 200)))
       "Invalid arguments in: dir-file->name --- expected: empty-directory? --- received: extend-directory")
    )

   (test-case
    "exn 7. extend-dir->f-1 exception test"
    (342-check-exn
       (extend-directory->f-1 (empty-directory "CS342") )
       "Invalid arguments in: extend-dir->f-1 --- expected: extend-dir? --- received: empty-dir")
    )

   (test-case
    "extend-dir->f-2 exception test"
    (342-check-exn
       (extend-directory->f-2 (empty-directory "CS342") )
       "Invalid arguments in: extend-dir->f-2 --- expected: extend-dir? --- received: empty-dir")
    )

   )
  )
