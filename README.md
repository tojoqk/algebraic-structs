# algebraic-structures

Provides useful algebraic structures for programming using parameterized module.

## Install

Run `chicken-install` in the project's root directory.

```
$ cd algebraic-structures
$ chicken-install
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

- Monad
  - [optional](./examples/optional.scm)
  - [state](./examples/state.scm)

