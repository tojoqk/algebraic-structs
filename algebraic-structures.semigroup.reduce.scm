(functor ((algebraic-structures semigroup reduce) (S (<>)) (R (reduce))) (reduce)
  (import scheme S (rename R (reduce reducible:reduce)))

  (define (reduce xs) (reducible:reduce <> xs)))
