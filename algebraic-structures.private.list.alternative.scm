(module (algebraic-structures private list alternative) (alt empty)
  (import (except scheme map apply)
          (chicken module)
          (only (algebraic-structures list applicative)))
  (reexport (algebraic-structures list applicative))

  (define empty '())

  (define (alt xs ys)
    (append xs ys)))
