(functor ((algebraic-structs monad make) (M (pure map map2 >>=)))
    (pure map map2 >>= do)
  (import (rename scheme (map scheme:map) (do scheme:do))
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
                      (if (and (symbol? stx) (compare stx (inject '<-)))
                          `(>>= ,expr (lambda (,var) ,acc))
                          `(>>= ,binding (lambda (_) ,acc)))]
                     [(let-stx var =-stx expr)
                      (cond ((and (symbol? let-stx) (compare let-stx (inject 'let))
                                  (symbol? =-stx) (compare =-stx (inject '=)))
                             `((lambda (,var) ,acc) ,expr))
                            (else
                             `(>>= ,binding (lambda (_) ,acc))))]
                     [expr
                      `(>>= ,expr (lambda (_) ,acc))]))
                 (last body)
                 (butlast body))])))))
