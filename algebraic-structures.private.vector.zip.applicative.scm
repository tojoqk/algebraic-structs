(module (algebraic-structures private vector zip applicative) ()
  (import scheme
          (chicken module)
          (only (srfi 133) vector-map)
          (only (algebraic-structures vector functor)))
  (export pure map2)
  (reexport (algebraic-structures vector functor))

  (define (pure x) (vector x))

  (define (map2 f xs ys)
    (vector-map f xs ys)))
