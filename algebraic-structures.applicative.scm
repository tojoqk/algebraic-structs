(functor ((algebraic-structures applicative) (A (pure map1 map2)))
    (pure map1 map2 map apply)
  (import (rename scheme (map scheme:map) (apply scheme:apply))
          (only (chicken base) sub1 add1 foldl case-lambda)
          (only A pure map1 map2)
          matchable)

  (define (curry-n f n)
    (let rec ((i n)
              (k (lambda (args)
                   (scheme:apply f args))))
      (if (= i 1)
          (lambda (x) (k (list x)))
          (lambda (x)
            (rec (sub1 i)
                 (lambda (args)
                   (k (cons x args))))))))

  (define map
    (case-lambda
      ((f x) (map1 f x))
      ((f x y) (map2 f x y))
      ((f x . xs)
       (let ((g (curry-n f (add1 (length xs)))))
         (foldl apply (apply (pure g) x) xs)))))

  (define (apply a1 a2)
    (map2 (lambda (f x) (f x)) a1 a2)))
