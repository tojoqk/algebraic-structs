(functor ((algebraic-structs monoid make fold) (M (op id)) (F (foldl foldr))) (fold)
  (import scheme M F)

  (define (fold x) (foldl op id x)))
