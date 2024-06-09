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

(import (only (algebraic-structs functor make))
        (only (algebraic-structs applicative make))
        (only (algebraic-structs monad make)))
(module (data state functor) = ((algebraic-structs functor make) (data state)))
(module (data state applicative) = ((algebraic-structs applicative make) (data state)))
(module (data state monad) = ((algebraic-structs monad make) (data state)))

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
