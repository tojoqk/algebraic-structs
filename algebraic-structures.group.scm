(functor ((algebraic-structures group) (M (op unit inv)))
    (op unit inv pow)
  (import (only M op unit inv)
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
                    (op acc x)))))))
