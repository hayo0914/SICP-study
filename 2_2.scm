; 2.2 Hierachical Data and the Closure Property
;
(cons 1 2)
(list 1 2)

(define (list-ref items n)
  (if (= n 0)
    (car items)
    (list-ref (cdr items) (- n 1))))
(define squares (list 1 4 9 16 25))
(list-ref squares 3)

(define (length items)
  (if (null? items)
    0
    (+ 1 (length (cdr items)))))
(define odds (list 1 3 5 7))
(length odds)

(append squares odds)

; Ex 2.17
(define (last-pair items)
  (if (equal? (cdr items) nil)
    items
    (last-pair (cdr items))))
(last-pair odds)
(last-pair (list 23 71 149 34))

; Ex 2.18
(define (reverse items)
  (let ((len (length items)))
    (define (iter result rest)
      (if (null? rest)
        result
        (iter
          (cons (car rest) result)
          (cdr rest))))
    (iter nil items)))
(display (reverse odds))

; Ex 2.19
; Skip

; Ex 2.20
(define (f x y . z)
  (display x)
  (newline)
  (display y)
  (newline)
  (display z)
  (newline))
(f 1 2 3 4 5)
; 1
; 2
; (3 4 5)

(define (same-parity x . others)
  (let ((parity (even? x)))
    (define (iter result rest)
      (if (null? rest)
        result
        (iter
          (if (equal? parity (even? (car rest)))
            (append result (list (car rest)))
            result)
          (cdr rest))))
    (iter (list x) others)))
(display (same-parity 1 2 3 4 5 6 7))
(display (same-parity 2 3 4 5 6 7))


(define (map proc items)
  (if (null? items)
    nil
    (cons (proc (car items))
          (map proc (cdr items)))))

(display (map abs (list -10 2.5 -11.6 17)))
(display (map (lambda (x) (* x x))
              (list 1 2 3 4)))

; Ex 2.21
(define (square x) (* x x))
(define (square-list items)
  (if (null? items)
    nil
    (cons (square (car items))
          (square-list (cdr items)))))
(square-list (list 1 2 3))

(define (square-list items)
  (map (lambda (item)
         (square item))
       items))
(square-list (list 1 2 3))

; Ex 2.22
; skip

; Ex 2.23
(define (for-each proc items)
  (proc (car items))
  (if (not (null? (cdr items)))
    (for-each proc (cdr items))))
(for-each
  (lambda (x)
    (newline)
    (display x))
  (list 57 321 88))

; 2.2.2 Hierarchical Structures

(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))
(count-leaves (cons (cons 20 nil) (list 20 1 2 3 (list 20 50))))

; Ex 2.24
;
; ( 1 ( 2 ( 3 4 ))) Box
;   ^
;  / \
;  1  (2 (3 4)) Box
;      ^
;     / \
;    2   (3 4) Box
;         ^
;        / \
;       3   4

; Ex 2.25

(car (cdr (car (cdr (cdr (list 1 3 (list 5 7) 9))))))

(car (car (list (list 7))))


; Ex 2.26
(define x (list 1 2 3))
(define y (list 4 5 6))

(append x y)
(cons x y)
(list x y)

; Ex 2.27
(define (deep-reverse items)
  (define (iter result rest)
    (cond
      ((null? rest)
       result)
      ((pair? (car rest))
       (iter
         (cons (deep-reverse (car rest)) result)
         (cdr rest)))
      (else
        (iter
          (cons (car rest) result)
          (cdr rest)))))
  (iter nil items))
(display (deep-reverse (list (list 1 2) (list 3 4))))
(display (deep-reverse (list 1 2 3 4)))
(display (deep-reverse
           (list
             (list 1 2
                   (list 7 8 9 10))
             (list 3 4))))

; Ex 2.28
(define (fringe items)
  (define (iter result rest)
    (cond
      ((null? rest)
       result)
      ((pair? (car rest))
       (iter
         (append result (fringe (car rest)))
         (cdr rest)))
      (else
        (iter
          (append result (list (car rest)))
          (cdr rest)))))
  (iter nil items))
(display (fringe (list 1 (list 0 10 30) 3 4 (list 5 6 7 8))))
      
; Ex 2.29
(define (make-mobile left right)
  (list left right))
(define (make-branch length structure)
  (list length structure))

; a
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (car (cdr mobile)))
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (car (cdr branch)))

; b

; Bad version
(define (total-weight mobile)
  (define (iter result mobile)
    (cond ((null? mobile)
           0)
           ((pair? mobile)
            (+ result
               (total-weight
                 (branch-structure
                   (left-branch mobile)))
               (total-weight
                 (branch-structure
                   (right-branch mobile)))))
           (else (+ result mobile))))
  (iter 0 mobile))

(define a (make-mobile (make-branch 2 5) (make-branch 2 4))) 
(total-weight a)

; Improved Version
(define (total-weight mobile)
  (cond ((null? mobile)
         0)
        ((not (pair? mobile))
         mobile)
        (else (+ (total-weight
                   (branch-structure
                     (left-branch mobile)))
                 (total-weight
                   (branch-structure
                     (right-branch mobile)))))))

; c




