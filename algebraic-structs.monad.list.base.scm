(module (algebraic-structs monad list base) (pure map map2 >>=)
  (import (except scheme map)
          (algebraic-structs applicative list)
          (only (srfi 1) append-map))

  (define (>>= lst f)
    (append-map f lst)))
