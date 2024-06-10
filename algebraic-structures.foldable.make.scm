(functor ((algebraic-structures foldable make) (F (foldl foldr)))
    (foldl foldr length find any every ->list)
  (import (except scheme length) F
          (only (chicken base) add1 call/cc))

  (define (length xs)
    (foldl (lambda (acc _) (add1 acc))
           0
           xs))

  (define (find p? xs)
    (call/cc
     (lambda (k)
       (foldl (lambda (acc e)
                (if (p? e)
                    (k e)
                    acc))
              #f
              xs))))

  (define (any pred xs)
    (call/cc
     (lambda (return)
       (foldl (lambda (acc e)
                (cond ((pred e) => return)
                      (else acc)))
              #f
              xs))))

  (define (every pred xs)
    (call/cc
     (lambda (return)
       (foldl (lambda (acc e)
                (or (pred e) (return #f)))
              #t
              xs))))

  (define (->list xs)
    (foldr cons '() xs)))
