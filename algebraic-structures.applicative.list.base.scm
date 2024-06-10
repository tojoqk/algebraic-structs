(module (algebraic-structures applicative list base) (map pure map2)
  (import (except scheme map)
          (algebraic-structures functor list)
          (only (chicken base) atom? cut)
          (only (srfi 1) append! reverse!)
          matchable)

  (define (pure x)
    (list x))

  (define (rev-map f lst)
    (let loop ((lst lst)
               (acc '()))
      (match lst
        [() acc]
        [(h . t)
         (loop t (cons (f h) acc))])))

  (define (product op lst1 lst2)
    (let loop ((lst lst1)
               (acc '()))
      (match lst
        [() (reverse! acc)]
        [(h . t)
         (loop t
               (append! (rev-map (cut op h <>) lst2)
                        acc))])))

  (define map2 product))
