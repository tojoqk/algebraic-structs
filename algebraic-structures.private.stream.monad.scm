(module (algebraic-structures private stream monad) (>>=)
  (import (except scheme map apply)
          (chicken module)
          (srfi 41))
  (reexport (algebraic-structures stream applicative))

  (define-stream (stream-append-map f strm)
    (if (stream-null? strm)
        stream-null
        (stream-append (f (stream-car strm))
                       (stream-append-map f (stream-cdr strm)))))

  (define (>>= xs f)
    (stream-append-map f xs)))
