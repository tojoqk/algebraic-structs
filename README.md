# algebraic-structures

Provides useful algebraic structures for programming using parametric modules in Chicken Scheme.

## Install

Run `chicken-install` in the project's root directory.

```
$ cd algebraic-structures
$ chicken-install
```

### Requirements

- matchable
- srfi-41
- srfi-133

## Usage

### Define Semigroup, Monoid and Group

```scheme
(import (algebraic-structures semigroup)
        (algebraic-structures monoid)
        (algebraic-structures group)
        (algebraic-structures monoid fold)
        (algebraic-structures list foldable))

(module (mod7 semigroup) = (algebraic-structures semigroup)
  (import scheme
          (chicken module))
  (export <>)

  (define (<> x y)
    (assert (integer? x))
    (assert (integer? y))
    (assert (not (zero? x)))
    (assert (not (zero? y)))
    (modulo (* x y) 7)))

(module (mod7 monoid) = (algebraic-structures monoid)
  (import scheme
          (chicken module)
          (chicken base)
          (only (mod7 semigroup)))
  (reexport (mod7 semigroup))
  (export unit)

  (define unit 1))

(module (mod7 group) = (algebraic-structures group)
  (import scheme
          (chicken base)
          (chicken module)
          matchable
          (only (mod7 monoid)))
  (reexport (mod7 monoid))
  (export inv)

  (define (inv n)
    (assert (integer? n))
    (assert (not (zero? n)))
    (match (modulo n 7)
      (1 1)
      (2 4)
      (3 5)
      (4 2)
      (5 3)
      (6 6))))

(module (mod7 fold) = ((algebraic-structures monoid fold) (mod7 monoid) (algebraic-structures list foldable)))

(import (prefix (mod7 group) mod7:)
        (prefix (mod7 fold) mod7:))
```

In REPL:

```
> (map (cut mod7:pow 3 <>) '(0 1 2 3 4 5 6 7 8 9 10 11))
(1 3 2 6 4 5 1 3 2 6 4 5)
> (mod7:fold '(1 2 3 4 5 6))
6
```

### Monad Syntax

```scheme
(import (srfi 41)
        (prefix (algebraic-structures stream monad) stream:)
        (prefix (algebraic-structures stream alternative) stream:))

(define (pythagorean-triples)
  (stream:do (b <- (stream-from 1))
             (a <- (stream-range 1 b))
             (let c^2 = (+ (* a a) (* b b)))
             (let-values (c r) = (exact-integer-sqrt c^2))
             (stream:guard (zero? r))
             (stream (list a b c))))
```

In REPL:

```
> (stream->list (stream-take 10 (pythagorean-triples)))
((3 4 5) (6 8 10) (5 12 13) (9 12 15) (8 15 17) (12 16 20) (15 20 25) (20 21 29) (7 24 25) (10 24 26))
```

## Supported Features

- Semigroup: `(algebraic-structures semigroup)`
  - Number (product): `(algebraic-structures number product semigroup)`
  - Number (sum): `(algebraic-structures number sum semigroup)`
  - List: `(algebraic-structures list semigroup)`
  - Vector: `(algebraic-structures vector semigroup)`
  - Stream: `(algebraic-structures stream semigroup)`
- Semigroup.reduce: `(algebraic-structures semigroup reduce)`
- Monoid: `(algebraic-structures monoid)`
  - Number (product): `(algebraic-structures number product monoid)`
  - Number (sum): `(algebraic-structures number sum monoid)`
  - List: `(algebraic-structures list monoid)`
  - Vector: `(algebraic-structures vector monoid)`
  - Stream: `(algebraic-structures stream monoid)`
- Monoid.fold: `(algebraic-structures monoid fold)`
- Group
  - Number (product): `(algebraic-structures number product group)`
  - Number (sum): `(algebraic-structures number sum group)`
- Foldable: `(algebraic-structures foldable)` 
  - List: `(algebraic-structures list foldable)`
  - Vector: `(algebraic-structures vector foldable)`
  - Stream: `(algebraic-structures stream foldable)`
- Reducible: `(algebraic-structures reducible)` 
  - List: `(algebraic-structures list reducible)`
  - Vector: `(algebraic-structures vector reducible)`
  - Stream: `(algebraic-structures stream reducible)`
- Functor: `(algebraic-structures functor)` 
  - List: `(algebraic-structures list functor)`
  - Vector: `(algebraic-structures vector functor)`
  - Stream: `(algebraic-structures stream functor)`
- Applicative: `(algebraic-structures applicative)` 
  - List: `(algebraic-structures list applicative)`
  - List (zip): `(algebraic-structures list zip applicative)`
  - Vector (zip): `(algebraic-structures vector zip applicative)`
  - Stream: `(algebraic-structures stream applicative)`
  - Stream (zip): `(algebraic-structures stream zip applicative)`
- Monad: `(algebraic-structures monad)` 
  - List: `(algebraic-structures list monad)`
  - Stream: `(algebraic-structures stream monad)`
- Alternative: `(algebraic-structures alternative)` 
  - List: `(algebraic-structures list alternative)`
  - Stream: `(algebraic-structures stream alternative)`

## Examples

- Group
  - [mod7](./examples/mod7.scm)
- Monad
  - [optional](./examples/optional.scm)
  - [state](./examples/state.scm)
- Monad (`do` syntax)
  - [pythagorean-triples](./examples/pythagorean-triples.scm)
