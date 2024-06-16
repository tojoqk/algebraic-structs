(module (algebraic-structures private list monad) (>>=)
  (import (except scheme map apply)
          (chicken module)
          (only (srfi 1) append-map)
          (only (algebraic-structures list applicative)))
  (reexport (algebraic-structures list applicative))

  (define (>>= xs f)
    (append-map f xs)))
