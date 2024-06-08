(import (chicken load) (test))

(test-begin "algebraic-structs")

(import (prefix (algebraic-structs monoid list) list:))

(import (only (algebraic-structs monoid make fold)))
(import (prefix (algebraic-structs foldable list) list:))
(import (prefix (algebraic-structs foldable vector) vector:))
(import (prefix (algebraic-structs monoid number sum) sum:))
(import (prefix (algebraic-structs monoid number product) product:))

(import (prefix (algebraic-structs functor list) list:))
(import (prefix (algebraic-structs applicative list) list:))
(import (prefix (algebraic-structs monad list) list:))
(import (prefix (algebraic-structs alternative list) list:))

(import (prefix (only (scheme) apply) list:))

(test-begin "foldable")

(test-begin "foldable.list")

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


(test '(a b c d e) (list:->list '(a b c d e)))

(test-end "foldable.list")

(test-begin "foldable.vector")

(test '(a b c d e) (vector:foldr cons '() #(a b c d e)))
(test '(((((() a) b) c) d) e) (vector:foldl list '() #(a b c d e)))

(test 0 (vector:length #()))
(test 5 (vector:length #(a b c d e)))

(test #f (vector:find (constantly #t) #()))
(test #f (vector:find even? #(1 3 5 7)))
(test 4 (vector:find even? #(1 3 4 7 8)))

(test #f (vector:any (constantly #t) #()))
(test #f (vector:any (cut member 'x <>) #((a b c) (d e f))))
(test '(x f) (vector:any (cut member 'x <>) #((a b c) (d x f))))

(test #t (vector:every (constantly #f) #()))
(test #f (vector:every (cut member 'x <>) #((a b c) (d x f))))
(test '(x f) (vector:every (cut member 'x <>) #((a x c) (d x f))))

(test '(a b c d e) (vector:->list #(a b c d e)))

(test-end "foldable.vector")

(test-end "foldable")

(test-begin "monoid")

(test-begin "monoid.list")

(test '(a b c 1 2 3) (list:op '(a b c) '(1 2 3)))
(test '(a b c x y z 1 2 3) (list:op (list:op '(a b c) '(x y z)) '(1 2 3)))
(test '(a b c x y z 1 2 3) (list:op '(a b c) (list:op '(x y z) '(1 2 3))))

(test-end "monoid.list")

(test-begin "monoid.sum.fold.list")

(module sum-fold = ((algebraic-structs monoid make fold)
                    (algebraic-structs monoid number sum)
                    (algebraic-structs foldable list)))
(import (prefix sum-fold sum:))

(test 15 (sum:fold '(1 2 3 4 5)))
(test 0 (sum:fold '()))


(test-end "monoid.sum.fold.list")

(test-begin "monoid.product.fold.vector")

(module product-fold = ((algebraic-structs monoid make fold)
                    (algebraic-structs monoid number product)
                    (algebraic-structs foldable vector)))
(import (prefix product-fold product:))

(test 120 (product:fold #(1 2 3 4 5)))
(test 1 (product:fold #()))

(test-end "monoid.product.fold.vector")

(test-end "monoid")

(test-begin "functor")

(test '((a) (b) (c)) (list:map list '(a b c)))

(test-end "functor")

(test-begin "applicative")

(test '(a) (list:pure 'a))

(test '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2))
      (list:map2 list '(a b c) '(1 2)))

(test '((a 1 z) (a 2 z) (b 1 z) (b 2 z) (c 1 z) (c 2 z))
      (list:map* list '(a b c) '(1 2) '(z)))

(test-end "applicative")

(test-begin "monad")

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

(test '(9 25)
      (list:do (x <- '(2 3 4 5))
               (list:guard (odd? x))
               (list:pure (* x x))))

(test-end "alternative")

(test-end "algebraic-structs")

(test-exit)
