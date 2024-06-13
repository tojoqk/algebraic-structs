(functor ((algebraic-structures foldable) (F (fold)))
    (fold
     length
     count
     any
     every)
  (import (except scheme length)
          F
          (only (chicken base) add1 call/cc))

  (define (length xs)
    (fold (lambda (_ acc) (add1 acc))
          0
          xs))

  (define (count p? xs)
    (fold (lambda (e acc)
            (if (p? e)
                (add1 acc)
                acc))
          0
          xs))

  (define (any pred xs)
    (call/cc
     (lambda (return)
       (fold (lambda (e acc)
               (cond ((pred e) => return)
                     (else acc)))
             #f
             xs))))

  (define (every pred xs)
    (call/cc
     (lambda (return)
       (fold (lambda (e acc)
               (or (pred e) (return #f)))
             #t
             xs)))))
