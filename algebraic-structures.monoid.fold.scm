(functor ((algebraic-structures monoid fold) (M (op unit)) (F (fold))) (fold fold-map)
  (import (except scheme length)
          (only M op unit)
          (rename (only F fold) (fold foldable:fold)))

  (define (fold x) (foldable:fold op unit x))

  (define (fold-map f x)
    (foldable:fold (lambda (x acc)
                     (op (f x) acc))
                   unit
                   x)))
