(module (data optional) (<some> some some? some-value <none> none none?)
  (import scheme
          (chicken base)
          (chicken format))

  (define-record-type <some>
    (some value)
    some?
    (value some-value))

  (set! (record-printer <some>)
    (lambda (x out)
      (fprintf out "#<(some ~S)>" (some-value x))))

  (define-record-type <none>
    (none)
    none?)

  (set! (record-printer <none>)
    (lambda (_ out)
      (fprintf out "#<(none)>"))))

(module (data optional monad base) (pure map map2 >>=)
  (import (except scheme map)
          (prefix (data optional) opt:)
          matchable)

  (define (map f opt)
    (match opt
      [($ opt:<some> x) (opt:some (f x))]
      [($ opt:<none>) (opt:none)]))

  (define (pure x)
    (opt:some x))

  (define (map2 f opt1 opt2)
    (match opt1
      [($ opt:<some> x)
       (match opt2
         [($ opt:<some> y) (opt:some (f x y))]
         [($ opt:<none>) (opt:none)])]
      [($ opt:<none>) (opt:none)]))

  (define (>>= opt f)
    (match opt
      [($ opt:<some> x) (f x)]
      [($ opt:<none>) (opt:none)])))

(import (only (algebraic-structures functor))
        (only (algebraic-structures applicative))
        (only (algebraic-structures monad)))

(module (data optional functor) = ((algebraic-structures functor) (data optional monad base)))
(module (data optional applicative) = ((algebraic-structures applicative) (data optional monad base)))
(module (data optional monad) = ((algebraic-structures monad) (data optional monad base)))

(import (prefix (data optional) opt:)
        (prefix (data optional functor) opt:)
        (prefix (data optional applicative) opt:)
        (prefix (data optional monad) opt:))

;; (opt:map (lambda (x) (* x x)) (opt:pure 5)) => (some 25)
;; (opt:map (lambda (x) (* x x)) (opt:none)) => (none)

;; (opt:map* + (opt:pure 1) (opt:pure 2) (opt:pure 3)) => (some 6)
;; (opt:map* + (opt:pure 1) (opt:none) (opt:pure 3)) => (none)

;; (opt:do (x <- (opt:pure 3))
;;         (y <- (opt:pure 4))
;;         (opt:pure (+ x y)))
;; => (some 7)
