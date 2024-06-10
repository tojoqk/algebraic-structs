(module (algebraic-structures alternative list base) (pure map map2 alt empty)
  (import (except scheme map apply)
          (algebraic-structures applicative list))

  (define (alt x y)
    (append x y))

  (define empty '()))
