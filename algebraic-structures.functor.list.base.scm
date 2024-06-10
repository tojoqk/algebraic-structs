(module (algebraic-structures functor list base) (map)
  (import (rename (scheme) (map list:map)))

  (define (map f lst) (list:map f lst)))
