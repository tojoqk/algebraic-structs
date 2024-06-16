(module (algebraic-structures private number product) (<> unit inv)
  (import scheme)

  (define (<> x y) (* x y))

  (define unit 1)

  (define (inv x) (/ x)))
