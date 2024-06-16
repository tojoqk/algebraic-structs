(functor ((algebraic-structures semigroup reduce) (S (<>)) (R (reduce))) (reduce)
  (import scheme
          (only S <>)
          (rename (only R reduce) (reduce reducible:reduce)))

  (define (reduce xs) (reducible:reduce <> xs)))
