(functor ((algebraic-structures semigroup reduce) (S (op)) (R (reduce))) (reduce)
  (import scheme
          (only S op)
          (rename (only R reduce) (reduce reducible:reduce)))

  (define (reduce xs) (reducible:reduce op xs)))
