(functor ((algebraic-structures monad) (M (pure map1 map2 map apply >>=)))
    (pure map1 map2 map apply >>= do)
  (import (rename scheme
                  (apply scheme:apply)
                  (map scheme:map)
                  (do scheme:do))
          (chicken base)
          (only M pure map1 map2 map apply >>=))
  (import-for-syntax matchable
                     (chicken syntax)
                     (only (srfi 1) every last))

  (define-syntax do
    (er-macro-transformer
     (lambda (expr rename compare)
       (match expr
         [(_ body ...)
          (foldr (lambda (binding acc)
                   (match binding
                     [(var stx expr)
                      (if (and (symbol? var)
                               (symbol? stx)
                               (compare stx (rename '<-)))
                          `(,(rename '>>=) ,expr (,(rename 'lambda) (,var) ,acc))
                          `(,(rename '>>=) ,binding (,(rename 'lambda) (_) ,acc)))]
                     [(let-stx var =-stx expr)
                      (cond ((and (symbol? var)
                                  (symbol? let-stx) (compare let-stx 'let)
                                  (symbol? =-stx) (compare =-stx '=))
                             `((,(rename 'lambda) (,var) ,acc) ,expr))
                            ((and (list? var)
                                  (every symbol? var)
                                  (symbol? let-stx) (compare let-stx 'let-values)
                                  (symbol? =-stx) (compare =-stx '=))
                             `(,(rename 'receive) ,var ,expr ,acc))
                            (else
                             `(,(rename '>>=) ,binding (,(rename 'lambda) (_) ,acc))))]
                     [expr
                      `(,(rename '>>=) ,expr (,(rename 'lambda) (_) ,acc))]))
                 (last body)
                 (butlast body))])))))
