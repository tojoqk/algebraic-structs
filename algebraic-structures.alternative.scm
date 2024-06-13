(functor ((algebraic-structures alternative) (A (pure map1 map2 map apply alt empty)))
    (pure map1 map2 map apply alt empty guard)
  (import (except scheme map apply)
          (only (chicken base) void)
          A)

  (define (guard b)
    (if b
        (pure (void))
        empty)))
