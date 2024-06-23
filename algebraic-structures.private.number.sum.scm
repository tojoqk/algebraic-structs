(module (algebraic-structures private number sum) (op unit inv)
  (import scheme)

  (define (op x y) (+ x y))

  (define unit 0)

  (define (inv x) (- x)))
