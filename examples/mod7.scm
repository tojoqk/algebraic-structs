(import (algebraic-structures semigroup)
        (algebraic-structures monoid)
        (algebraic-structures group)
        (algebraic-structures monoid fold)
        (algebraic-structures list foldable))

(module (mod7 semigroup) = (algebraic-structures semigroup)
  (import scheme
          (chicken module)
          (only (chicken base) assert))
  (export <>)

  (define (<> x y)
    (assert (integer? x))
    (assert (integer? y))
    (assert (not (zero? x)))
    (assert (not (zero? y)))
    (modulo (* x y) 7)))

(module (mod7 monoid) = (algebraic-structures monoid)
  (import scheme
          (chicken module)
          (only (mod7 semigroup)))
  (reexport (mod7 semigroup))
  (export unit)

  (define unit 1))

(module (mod7 group) = (algebraic-structures group)
  (import scheme
          (only (chicken base) assert)
          (chicken module)
          matchable
          (only (mod7 monoid)))
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

(module (mod7 fold) = ((algebraic-structures monoid fold) (mod7 monoid) (algebraic-structures list foldable)))

;; (import (prefix (mod7 group) mod7:)
;;         (prefix (mod7 fold) mod7:))
