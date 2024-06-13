(import (algebraic-structures functor)
        (algebraic-structures applicative)
        (algebraic-structures monad))

(module (data state) (run get put)
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
      (cons (void) st))))

(module (data state functor) = (algebraic-structures functor)
  (import scheme
          matchable
          (chicken module))
  (export map1)

  (define (map1 f m)
    (lambda (st)
      (match-let ([(x . st*) (m st)])
        (cons (f x) st*)))))

(module (data state applicative) = (algebraic-structures applicative)
  (import scheme
          matchable
          (chicken module))
  (reexport (data state functor))
  (export pure map2)

  (define (pure x)
    (lambda (st) (cons x st)))

  (define (map2 f m1 m2)
    (lambda (st)
      (match-let* ([(x . st*) (m1 st)]
                   [(y . st**) (m2 st*)])
        (cons (f x y) st**)))))

(module (data state monad) = (algebraic-structures monad)
  (import (except scheme map apply)
          matchable
          (chicken module))
  (reexport (data state applicative))
  (export >>=)

  (define (>>= m f)
    (lambda (st)
      (match-let* ([(x . st*) (m st)]
                   [(x* . st**) ((f x) st*)])
        (cons x* st**)))))

(import (prefix (data state) st:)
        (prefix (data state monad) st:))

;; (st:run (st:do (x <- st:get)
;;                (let y = (* x 3))
;;                (st:put y)
;;                (z <- st:get)
;;                (st:pure z))
;;         5)
;; => 15
