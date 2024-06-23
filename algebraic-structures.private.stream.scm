(module (algebraic-structures private stream) (op unit fold reduce map1)
  (import scheme
          (srfi 41)
          (streams utils)
          (only (chicken base) assert))

  (define (op xs ys) (stream-append xs ys))

  (define unit stream-null)

  (define (fold f init xs)
    (stream-fold (lambda (x acc) (f acc x))
                 init
                 xs))

  (define (reduce f xs)
    (stream-fold-one f xs))

  (define (map1 f xs)
    (stream-map f xs)))
