(module (algebraic-structures monad list base) (pure map map2 >>=)
  (import (except scheme map)
          (algebraic-structures applicative list)
          (only (srfi 1) append-map))

  (define (>>= lst f)
    (append-map f lst)))
