(import (chicken load)
        (test)
        (srfi 41))

(test-begin "algebraic-structures")

(test-begin "semigroup")

(import (algebraic-structures semigroup))

(module (mod7 semigroup) = (algebraic-structures semigroup)
  (import scheme
          (chicken module)
          (chicken base))
  (export <>)

  (define (<> x y)
    (assert (integer? x))
    (assert (integer? y))
    (assert (not (zero? x)))
    (assert (not (zero? y)))
    (modulo (* x y) 7)))

(import (prefix (mod7 semigroup) mod7:))

(test 5 (mod7:<> 3 4))

(test-begin "list")

(import (prefix (algebraic-structures list semigroup) list:))
(test '(a b c) (list:<> '(a b) '(c)))

(test-end "list")

(test-begin "stream")

(import (prefix (algebraic-structures stream semigroup) stream:))
(test '(a b c) (stream->list (stream:<> (stream 'a 'b) (stream 'c))))

(test-end "stream")

(test-end "semigroup")

(test-begin "monoid")

(import (algebraic-structures monoid))

(module (mod7 monoid) = (algebraic-structures monoid)
  (import scheme
          (chicken module)
          (chicken base))
  (reexport (mod7 semigroup))
  (export unit)

  (define unit 1))

(import (prefix (mod7 monoid) mod7:)
        (srfi 1))

(test 1 mod7:unit)

(test-begin "list")

(import (prefix (algebraic-structures list monoid) list:))
(test '() (begin list:unit))

(test-end "list")

(test-begin "stream")

(import (prefix (algebraic-structures stream monoid) stream:))
(test '() (stream->list stream:unit))

(test-end "stream")

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

(import (prefix (algebraic-structures list foldable) list:))

(test '(e d c b a) (list:fold cons '() '(a b c d e)))

(test 0 (list:length '()))
(test 5 (list:length '(a b c d e)))

(test 0 (list:count even? '(1 3 5 7)))
(test 2 (list:count even? '(1 3 4 7 8)))

(test #f (list:any (constantly #t) '()))
(test #f (list:any (cut member 'x <>) '((a b c) (d e f))))
(test '(x f) (list:any (cut member 'x <>) '((a b c) (d x f))))

(test #t (list:every (constantly #f) '()))
(test #f (list:every (cut member 'x <>) '((a b c) (d x f))))
(test '(x f) (list:every (cut member 'x <>) '((a x c) (d x f))))

(test #t (list:member? 3 '(1 3 7 5) =))
(test #f (list:member? 3 '(1 7 5) =))
(test #t (list:member? 'c '(a b c) eq?))
(test #f (list:member? 'c '(a b) eq?))

(test-begin "stream")

(import (prefix (algebraic-structures stream foldable) stream:))

(test '(e d c b a) (stream:fold cons '() (stream 'a 'b 'c 'd 'e)))

(test 0 (stream:length stream-null))
(test 5 (stream:length (stream-take 5 (stream-from 1))))

(test 0 (stream:count even? (stream 1 3 5 7)))
(test 2 (stream:count even? (stream 1 3 4 7 8)))

(test #f (stream:any (constantly #t) stream-null))
(test #f (stream:any (cut member 'x <>) (stream '(a b c) '(d e f))))
(test '(x f) (stream:any (cut member 'x <>) (stream '(a b c) '(d x f))))
(test '(x f) (stream:any (cut member 'x <>) (stream '(a b c) '(d x f))))
(test #t (stream:any even? (stream-from 1)))

(test #t (stream:every (constantly #f) stream-null))
(test #f (stream:every (cut member 'x <>) (stream '(a b c) '(d x f))))
(test '(x f) (stream:every (cut member 'x <>) (stream '(a x c) '(d x f))))
(test #f (stream:every even? (stream-from 0)))

(test #t (stream:member? 3 (stream 1 3 7 5) =))
(test #f (stream:member? 3 (stream 1 7 5) =))
(test #t (stream:member? 'c (stream 'a 'b 'c) eq?))
(test #f (stream:member? 'c (stream 'a 'b) eq?))
(test #t (stream:member? 1000 (stream-from 1) =))

(test-end "stream")

(test-end "foldable")

(test-begin "reducible")

(import (prefix (algebraic-structures list reducible) list:))

(test 10 (list:reduce + '(1 2 3 4)))
(test -3 (list:minimum '(1 8 -3 5 4) <))
(test 8 (list:maximum '(1 8 -3 5 4) <))

(test-begin "stream")

(import (prefix (algebraic-structures stream reducible) stream:))

(test 10 (stream:reduce + (stream 1 2 3 4)))
(test -3 (stream:minimum (stream 1 8 -3 5 4) <))
(test 8 (stream:maximum (stream 1 8 -3 5 4) <))

(test-end "stream")

(test-end "reducible")

(test-begin "semigroup.reducible")

(module (sum semigroup) = (algebraic-structures semigroup)
  (import scheme
          (chicken base)
          (chicken module))
  (export <>)

  (define (<> x y)
    (+ x y)))

(import (algebraic-structures semigroup reduce))
(module (sum reduce) = ((algebraic-structures semigroup reduce)
                        (sum semigroup)
                        (algebraic-structures list reducible)))

(import (prefix (sum reduce) sum:))

(test 3 (sum:reduce '(1 2)))

(test-end "semigroup.reducible")

(test-begin "monoid.fold")

(module (product semigroup) = (algebraic-structures semigroup)
  (import scheme
          (chicken base)
          (chicken module))
  (export <>)

  (define (<> x y)
    (assert (number? x))
    (assert (not (zero? x)))
    (assert (number? y))
    (assert (not (zero? y)))
    (* x y)))

(module (product monoid) = (algebraic-structures monoid)
  (import scheme
          (chicken base)
          (chicken module))
  (reexport (product semigroup))
  (export unit)

  (define unit 1))

(import (algebraic-structures monoid fold))
(module (product fold) = ((algebraic-structures monoid fold)
                          (product monoid)
                          (algebraic-structures list foldable)))

(import (prefix (product monoid) product:))
(import (prefix (product fold) product:))

(test 1 (product:fold '()))
(test 120 (product:fold '(1 2 3 4 5)))
(test 1 (product:fold-map error '()))
(test 6 (product:fold-map length '((a a a) (a a) (a))))

(test-end "monoid.fold")

(test-begin "functor")

(import (prefix (algebraic-structures list functor) list:))

(test '((a) (b) (c)) (list:map1 list '(a b c)))

(test-begin "stream")

(import (prefix (algebraic-structures stream functor) stream:))

(test '((a) (b) (c)) (stream->list (stream:map1 list (stream 'a 'b 'c))))

(test-end "stream")

(test-end "functor")

(test-begin "applicative")

(import (prefix (algebraic-structures list applicative) list:))

(test '(a) (list:pure 'a))

(test '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2))
      (list:map2 list '(a b c) '(1 2)))

(test '((a 1 z) (a 2 z) (b 1 z) (b 2 z) (c 1 z) (c 2 z))
      (list:map list '(a b c) '(1 2) '(z)))

(test-begin "stream")

(import (prefix (algebraic-structures stream applicative) stream:))

(test '(a) (stream->list (stream:pure 'a)))

(test '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2))
      (stream->list (stream:map2 list (stream 'a 'b 'c) (stream 1 2))))

(test '((a 1 z) (a 2 z) (b 1 z) (b 2 z) (c 1 z) (c 2 z))
      (stream->list
       (stream:map list (stream 'a 'b 'c) (stream 1 2) (stream 'z))))

(test '((1 a) (1 b) (1 c) (2 a))
      (stream->list
       (stream-take 4 (stream:map2 list (stream-from 1) (stream 'a 'b 'c)))))

(test-end "stream")

(test-begin "list.zip")

(import (prefix (algebraic-structures list zip applicative) list-zip:))

(test '(a) (list:pure 'a))

(test '((a 1) (b 2))
      (list-zip:map2 list '(a b c) '(1 2)))

(test-end "list.zip")

(test-begin "stream.zip")

(import (prefix (algebraic-structures stream zip applicative) stream-zip:))

(test '(a) (stream->list (stream:pure 'a)))

(test '((a 1) (b 2))
      (stream->list (stream-zip:map2 list (stream 'a 'b 'c) (stream 1 2))))

(test-end "stream.zip")

(test-end "applicative")

(test-begin "monad")

(import (prefix (algebraic-structures list monad) list:))

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

(test-begin "stream")

(import (prefix (algebraic-structures stream monad) stream:))

(test '((1 a) (2 a))
      (stream->list
       (stream:>>= (stream:pure 'a)
                   (lambda (x)
                     (stream (list 1 x)
                             (list 2 x))))))

(test-end "stream")

(test-end "monad")

(test-begin "alternative")

(import (prefix (algebraic-structures list alternative) list:))

(test '(9 25)
      (list:do (x <- '(2 3 4 5))
               (list:guard (odd? x))
               (list:pure (* x x))))

(test-begin "stream")

(import (prefix (algebraic-structures stream alternative) stream:))

(test '((3 4 5) (6 8 10) (5 12 13) (9 12 15) (8 15 17))
      (stream->list
       (stream-take 5
                    (stream:do (b <- (stream-from 1))
                               (a <- (stream-range 1 b))
                               (let c^2 = (+ (* a a) (* b b)))
                               (let-values (c r) = (exact-integer-sqrt c^2))
                               (stream:guard (= r 0))
                               (stream:pure (list a b c))))))

(test-end "stream")

(test-end "alternative")

(test-end "algebraic-structures")

(test-exit)
