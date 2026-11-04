###  Unreleased
- drop Ruby 3.0 and 3.1 (end of life); requires Ruby >= 3.2
- fix: a block with two required args and a splat (`|k, v, *rest|`) gets the key and value instead of the value as `k`
- fix: a `false` handle passed together with a block raises ArgumentError instead of being ignored
- feature: a callable (lambda, proc, Method) works as a key or value handle: `users.rekey(:id, ->(u) { u.name.upcase })`. Requires pluckit >= 1.3

###  4.1.0  (2026-04-10)
- ruby version / gem updates

###  4.0.0  (2018-10-08)
- 7a49250 better monkey patching tests
- 9d94818 extend self
- 574461c clean up arity handling, expand tests
- 4b85ea6 require a key handle or block...for a nil key operation, use PluckIt
- d6cba35 fix unit test requires

