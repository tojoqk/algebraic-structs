(module (algebraic-structures private string) (op unit)
  (import scheme)

  (define (op x y) (string-append x y))

  (define unit ""))
