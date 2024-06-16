(module (algebraic-structures private stream zip applicative) ()
  (import scheme
          (srfi 41)
          (chicken module)
          (only (algebraic-structures stream functor)))
  (export pure map2)
  (reexport (algebraic-structures stream functor))

  (define (pure x) (stream x))

  (define (map2 f xs ys)
    (stream-map f xs ys)))
