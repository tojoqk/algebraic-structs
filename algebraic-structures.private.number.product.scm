(module (algebraic-structures private number product) (op unit inv)
  (import scheme)

  (define (op x y) (* x y))

  (define unit 1)

  (define (inv x) (/ x)))
