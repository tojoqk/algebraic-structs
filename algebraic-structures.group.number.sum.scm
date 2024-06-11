(import (only (algebraic-structures group make)))
(module (algebraic-structures group number sum) = (algebraic-structures group make)
  (import scheme
          (chicken module)
          (algebraic-structures monoid number sum))
  (export <> unit inv)

  (define (inv x) (- x)))
