(module (algebraic-structs alternative list base) (pure map map2 alt empty)
  (import (except scheme map apply)
          (algebraic-structs applicative list))

  (define (alt x y)
    (append x y))

  (define empty '()))
