(functor ((algebraic-structures monoid make fold) (M (op unit)) (F (foldl foldr))) (fold)
  (import scheme M F)

  (define (fold x) (foldl op unit x)))
