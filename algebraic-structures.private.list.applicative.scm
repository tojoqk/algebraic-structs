(module (algebraic-structures private list applicative) ()
  (import scheme
          (only (srfi 1) append! reverse!)
          (only (chicken base) assert cut)
          (only matchable match)
          (chicken module)
          (only (algebraic-structures list functor)))
  (export pure map2)
  (reexport (algebraic-structures list functor))

  (define (pure x) (list x))

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
