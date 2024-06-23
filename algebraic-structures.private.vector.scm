(module (algebraic-structures private vector) (op unit fold reduce map1)
  (import (except scheme
                  vector-fill! vector->list list->vector)
          (only (chicken base) add1 assert)
          (srfi 133))

  (define (op xs ys) (vector-append xs ys))

  (define unit #())

  (define (fold f z v)
    (vector-fold (lambda (x y) (f y x))
                 z
                 v))

  (define (reduce f v)
    (assert (not (zero? (vector-length v))))
    (let ((len (vector-length v)))
      (let loop ((i 1)
                 (acc (vector-ref v 0)))
        (if (= i len)
            acc
            (loop (add1 i)
                  (f (vector-ref v i) acc))))))

  (define (map1 f v)
    (vector-map f v)))
