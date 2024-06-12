(module (data state)
    (run get put map pure map2 >>=)
  (import (except scheme map)
          (only (chicken base) void assert)
          matchable)

  (define (run m init)
    (car (m init)))

  (define get
    (lambda (st)
      (cons st st)))

  (define (put st)
    (lambda (_st)
      (cons (void) st)))
        
  (define (map f m)
    (lambda (st)
      (match-let ([(x . st*) (m st)])
        (cons (f x) st*))))

  (define (pure x)
    (lambda (st) (cons x st)))

  (define (map2 f m1 m2)
    (lambda (st)
      (match-let* ([(x . st*) (m1 st)]
                   [(y . st**) (m2 st*)])
        (cons (f x y) st**))))

  (define (>>= m f)
    (lambda (st)
      (match-let* ([(x . st*) (m st)]
                   [(x* . st**) ((f x) st*)])
        (cons x* st**)))))

(import (only (algebraic-structures functor))
        (only (algebraic-structures applicative))
        (only (algebraic-structures monad)))
(module (data state functor) = ((algebraic-structures functor) (data state)))
(module (data state applicative) = ((algebraic-structures applicative) (data state)))
(module (data state monad) = ((algebraic-structures monad) (data state)))

(import (prefix (data state) st:)
        (prefix (data state functor) st:)
        (prefix (data state applicative) st:)
        (prefix (data state monad) st:))

;; (st:run (st:do (x <- st:get)
;;                (let y = (* x 3))
;;                (st:put y)
;;                (z <- st:get)
;;                (st:pure z))
;;         5)
;; => 15
