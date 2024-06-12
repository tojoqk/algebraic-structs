(import (chicken load) (test))

(test-begin "algebraic-structures")

(test-begin "monoid")

(import (algebraic-structures monoid))

(module (mod7 monoid) = (algebraic-structures monoid)
  (import scheme
          (chicken module)
          (chicken base))
  (export <> unit)

  (define (<> x y)
    (assert (integer? x))
    (assert (integer? y))
    (assert (not (zero? x)))
    (assert (not (zero? y)))
    (modulo (* x y) 7))

  (define unit 1))

(import (prefix (mod7 monoid) mod7:)
        (srfi 1))

(test 5 (mod7:<> 3 4))
(test 1 mod7:unit)

(test-end "monoid")

(test-begin "group")

(import (algebraic-structures group))
(module (mod7 group) = (algebraic-structures group)
  (import scheme
          (chicken base)
          (chicken module)
          matchable)
  (reexport (mod7 monoid))
  (export inv)

  (define (inv n)
    (assert (integer? n))
    (assert (not (zero? n)))
    (match (modulo n 7)
      (1 1)
      (2 4)
      (3 5)
      (4 2)
      (5 3)
      (6 6))))

(import (prefix (mod7 group) mod7:))

(test (make-list 6 mod7:unit)
      (map mod7:<>
           '(1 2 3 4 5 6)
           (map mod7:inv '(1 2 3 4 5 6))))

(test '(3 2 6 4 5 1)
      (map (cut mod7:pow 3 <>) '(1 2 3 4 5 6)))

(test (mod7:inv 4) (mod7:pow 4 -1))

(test-end "group")

(test-begin "foldable")

(import (algebraic-structures foldable))

(module (data list foldable) = (algebraic-structures foldable)
  (import (chicken module))
  (reexport (only (chicken base) foldl foldr)))

(import (prefix (data list foldable) list:))

(test '(a b c d e) (list:foldr cons '() '(a b c d e)))
(test '(((((() a) b) c) d) e) (list:foldl list '() '(a b c d e)))

(test 0 (list:length '()))
(test 5 (list:length '(a b c d e)))

(test #f (list:find (constantly #t) '()))
(test #f (list:find even? '(1 3 5 7)))
(test 4 (list:find even? '(1 3 4 7 8)))

(test #f (list:any (constantly #t) '()))
(test #f (list:any (cut member 'x <>) '((a b c) (d e f))))
(test '(x f) (list:any (cut member 'x <>) '((a b c) (d x f))))

(test #t (list:every (constantly #f) '()))
(test #f (list:every (cut member 'x <>) '((a b c) (d x f))))
(test '(x f) (list:every (cut member 'x <>) '((a x c) (d x f))))

(test-end "foldable")

(test-begin "monoid.fold")

(module (product monoid) = (algebraic-structures monoid)
  (import scheme
          (chicken base)
          (chicken module))
  (export <> unit)

  (define (<> x y)
    (assert (number? x))
    (assert (not (zero? x)))
    (assert (number? y))
    (assert (not (zero? y)))
    (* x y))

  (define unit 1))

(import (algebraic-structures monoid fold))
(module (product fold) = ((algebraic-structures monoid fold) (product monoid) (data list foldable)))

(import (prefix (product monoid) product:))
(import (prefix (product fold) product:))

(test 120 (product:fold '(1 2 3 4 5)))

(test-end "monoid.fold")

(test-begin "functor")

(import (algebraic-structures functor))
(module (data list functor) = (algebraic-structures functor)
  (import scheme (chicken module))
  (export map))

(import (prefix (data list functor) list:))

(test '((a) (b) (c)) (list:map list '(a b c)))

(test-end "functor")

(test-begin "applicative")

(import (algebraic-structures applicative))
(module (data list applicative) = (algebraic-structures applicative)
  (import (except scheme map)
          (chicken module)
          (srfi 1)
          matchable
          (chicken base)
          (data list functor))
  (reexport (data list functor))
  (export pure map2)

  (define (pure x)
    (list x))

  (define (rev-map f lst)
    (let loop ((lst lst)
               (acc '()))
      (match lst
        [() acc]
        [(h . t)
         (loop t (cons (f h) acc))])))

  (define (product op lst1 lst2)
    (let loop ((lst lst1)
               (acc '()))
      (match lst
        [() (reverse! acc)]
        [(h . t)
         (loop t
               (append! (rev-map (cut op h <>) lst2)
                        acc))])))

  (define map2 product))

(import (prefix (data list applicative) list:))

(test '(a) (list:pure 'a))

(test '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2))
      (list:map2 list '(a b c) '(1 2)))

(test '((a 1 z) (a 2 z) (b 1 z) (b 2 z) (c 1 z) (c 2 z))
      (list:map* list '(a b c) '(1 2) '(z)))

(test-end "applicative")

(test-begin "monad")

(import (algebraic-structures monad))
(module (data list monad) = (algebraic-structures monad)
  (import (except scheme map)
          (chicken module)
          (srfi 1))
  (reexport (data list applicative))
  (export >>=)

  (define (>>= lst f)
    (append-map f lst)))

(import (prefix (data list monad) list:))

(test '((1 a) (2 a))
      (list:>>= (list:pure 'a)
                (lambda (x)
                  (list (list 1 x)
                        (list 2 x)))))

(test '(210 330 350 550)
      (list:do (x <- '(3 5))
               (let y = 10)
               (z <- '(7 11))
               (list 2)
               (list:pure (* x y z))))

(test-end "monad")

(test-begin "alternative")

(import (algebraic-structures alternative))
(module (data list alternative) = (algebraic-structures alternative)
  (import (except scheme map)
          (chicken module)
          (chicken base)
          (data list applicative))
  (reexport (data list applicative))
  (export alt empty)

  (define (alt x y)
    (append x y))

  (define empty '()))

(import (prefix (data list alternative) list:))

(test '(9 25)
      (list:do (x <- '(2 3 4 5))
               (list:guard (odd? x))
               (list:pure (* x x))))

(test-end "alternative")

(test-end "algebraic-structures")

(test-exit)
