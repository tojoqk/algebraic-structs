(module (algebraic-structures private stream applicative) ()
  (import scheme
          (srfi 41)
          (only (chicken base) cute)
          (chicken module)
          (only (algebraic-structures stream functor)))
  (export pure map2)
  (reexport (algebraic-structures stream functor))

  (define (pure x) (stream x))

  (define-stream (product op s1 s2)
    (if (stream-null? s1)
        stream-null
        (stream-append (stream-map (cute op (stream-car s1) <>) s2)
                       (product op (stream-cdr s1) s2))))

  (define map2 product))
