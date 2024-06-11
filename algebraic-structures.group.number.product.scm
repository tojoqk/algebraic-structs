(import (only (algebraic-structures group make)))
(module (algebraic-structures group number product) = (algebraic-structures group make)
  (import scheme
          (chicken module)
          (algebraic-structures monoid number product))
  (export <> unit inv)

  (define (inv x) (/ x)))
