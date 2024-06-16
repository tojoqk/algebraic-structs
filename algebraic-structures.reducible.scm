(functor ((algebraic-structures reducible) (R (reduce)))
    (reduce
     maximum
     minimum)
  (import scheme
          (only R reduce))

  (define (minimum xs less?)
    (reduce (lambda (e acc)
              (if (less? e acc)
                  e
                  acc))
            xs))

  (define (maximum xs less?)
    (reduce (lambda (e acc)
              (if (less? e acc)
                  acc
                  e))
            xs)))
