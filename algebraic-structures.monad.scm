(functor ((algebraic-structures monad) (M (pure map1 map2 map apply >>=)))
    (pure map1 map2 map apply >>= do)
  (import (rename scheme
                  (apply scheme:apply)
                  (map scheme:map)
                  (do scheme:do))
          M)
  (import-for-syntax matchable
                     (chicken syntax)
                     (only (srfi 1) last))

  (define-syntax do
    (ir-macro-transformer
     (lambda (expr inject compare)
       (match expr
         [(_ body ...)
          (foldr (lambda (binding acc)
                   (match binding
                     [(var stx expr)
                      (if (and (symbol? var)
                               (symbol? stx)
                               (compare stx '<-))
                          `(>>= ,expr (lambda (,var) ,acc))
                          `(>>= ,binding (lambda (_) ,acc)))]
                     [(let-stx var =-stx expr)
                      (cond ((and (symbol? var)
                                  (symbol? let-stx) (compare let-stx (inject 'let))
                                  (symbol? =-stx) (compare =-stx (inject '=)))
                             `((lambda (,var) ,acc) ,expr))
                            (else
                             `(>>= ,binding (lambda (_) ,acc))))]
                     [expr
                      `(>>= ,expr (lambda (_) ,acc))]))
                 (last body)
                 (butlast body))])))))
