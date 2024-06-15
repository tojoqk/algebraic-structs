(module (algebraic-structures private list) (<> unit fold reduce map1)
  (import scheme
          (rename (only (srfi 1) fold reduce)
                  (fold srfi:fold)
                  (reduce srfi:reduce))
          (only (chicken base) assert))

  (define <> append)

  (define unit '())

  (define fold srfi:fold)

  (define (reduce f xs)
    (assert (not (null? xs)))
    (srfi:reduce f #f xs))

  (define (map1 f xs)
    (map f xs)))
