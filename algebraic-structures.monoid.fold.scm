(functor ((algebraic-structures monoid fold) (M (<> unit)) (F (fold))) (fold fold-map)
  (import (except scheme length)
          (only M <> unit)
          (rename (only F fold) (fold foldable:fold)))

  (define (fold x) (foldable:fold <> unit x))

  (define (fold-map f x)
    (foldable:fold (lambda (x acc)
                     (<> (f x) acc))
                   unit
                   x)))
