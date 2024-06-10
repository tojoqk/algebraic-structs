(module (algebraic-structs foldable vector base) (foldl foldr)
  (import scheme
          (only (chicken base) add1 sub1))

  (define (foldl f z v)
    (let ((len (vector-length v)))
      (let loop ((i 0)
                 (acc z))
        (if (= i len)
            acc
            (loop (add1 i)
                  (f acc (vector-ref v i)))))))

  (define (foldr f z v)
    (let ((len (vector-length v)))
      (let loop ((i (sub1 len))
                 (acc z))
        (if (< i 0)
            acc
            (loop (sub1 i)
                  (f (vector-ref v i) acc)))))))
