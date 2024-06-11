(functor ((algebraic-structures group make) (M (<> unit inv)))
    (<> unit inv pow)
  (import M
          scheme
          (chicken base))

  (define (pow x n)
    (assert (exact-integer? n))
    (if (negative? n)
        (pow (inv x) (- n))
        (let loop ((i n)
                   (acc unit))
          (if (= i 0)
              acc
              (loop (sub1 i)
                    (<> acc x)))))))
