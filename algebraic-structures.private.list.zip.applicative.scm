(module (algebraic-structures private list zip applicative) ()
  (import scheme
          (rename (only (srfi 1) fold reduce)
                  (fold srfi:fold)
                  (reduce srfi:reduce))
          (only (chicken base) assert)
          (chicken module))
  (export pure map2)
  (reexport (algebraic-structures list functor))

  (define (pure x) (list x))

  (define (map2 f xs ys)
    (map f xs ys)))
