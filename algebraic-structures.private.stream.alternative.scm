(module (algebraic-structures private stream alternative) (alt empty)
  (import (except scheme map apply)
          (srfi 41)
          (chicken module)
          (only (algebraic-structures stream applicative)))
  (reexport (algebraic-structures stream applicative))

  (define empty stream-null)

  (define (alt xs ys)
    (stream-append xs ys)))
