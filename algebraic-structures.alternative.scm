(functor ((algebraic-structures alternative) (A (pure map map2 alt empty)))
    (pure map map2 alt empty guard)
  (import (except scheme map apply)
          (only (chicken base) void)
          A)

  (define (guard b)
    (if b
        (pure (void))
        empty)))
