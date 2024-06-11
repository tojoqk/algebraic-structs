(functor ((algebraic-structures monoid make fold) (M (<> unit)) (F (foldl foldr))) (fold)
  (import scheme M F)

  (define (fold x) (foldl <> unit x)))
