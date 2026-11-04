Rekey
======
![Gem](https://img.shields.io/gem/dt/rekey?style=plastic)
[![codecov](https://codecov.io/gh/dpep/rekey_rb/branch/main/graph/badge.svg?token=Z6W48XUEQD)](https://codecov.io/gh/dpep/rekey_rb)

Turn an Enumerable into a Hash, with derived keys and values.

```ruby
require "rekey"

rows = [
  { id: 1, name: "alice" },
  { id: 2, name: "bob" },
]

rows.rekey(:id)
# => {1 => {id: 1, name: "alice"}, 2 => {id: 2, name: "bob"}}

rows.rekey(:id, :name)
# => {1 => "alice", 2 => "bob"}
```

#### Install
```gem install rekey```


#### Handles
`rekey(key_handle, value_handle = nil)`. Without a value handle, each element is its own value.

[pluckit](https://github.com/dpep/pluckit_rb) resolves handles, so a handle can be a Hash key, a method name, an array index, a Range, or a Regexp:

```ruby
[[1, "a"], [2, "b"]].rekey(0, 1)
# => {1 => "a", 2 => "b"}

%w[apple banana].rekey(0..2, :length)
# => {"app" => 5, "ban" => 6}

%w[apple banana].rekey(/^./)
# => {"a" => "apple", "b" => "banana"}
```

A callable (lambda, proc, Method) works as either handle:

```ruby
rows.rekey(:id, ->(r) { r[:name].upcase })
# => {1 => "ALICE", 2 => "BOB"}

[1, 2].rekey(:itself, 10.method(:*))
# => {1 => 10, 2 => 20}
```


#### Blocks
A block computes the key; the element stays the value.

```ruby
[2, 4, 6].rekey { |v| v / 2 }
# => {1 => 2, 2 => 4, 3 => 6}
```

Pass handles or a block, not both. Mixing them raises ArgumentError.


#### Hash input
Handles and one-parameter blocks look at the values. The outer keys are dropped.

```ruby
users = {
  x: { id: 1, name: "alice" },
  y: { id: 2, name: "bob" },
}

users.rekey(:id, :name)
# => {1 => "alice", 2 => "bob"}
```

A block with two required parameters gets the key and value:

```ruby
{ a: 1 }.rekey { |k, v| "#{k}#{v}" }
# => {"a1" => 1}
```

On anything other than a Hash, a two-parameter block raises ArgumentError.


#### Duplicate keys
The last one wins, as with `to_h` and `index_by`.

```ruby
[{ id: 1, v: "a" }, { id: 1, v: "b" }].rekey(:id, :v)
# => {1 => "b"}
```

Watch for a handle that misses. A typo, or `"id"` on symbol-keyed hashes, gives `nil` for every row, so the whole result collapses to one entry:

```ruby
rows.rekey("id")
# => {nil => {id: 2, name: "bob"}}
```


#### Without the monkey patch
`require "rekey"` adds `#rekey` to every Enumerable. To skip the global patch, load the module alone and use the refinement, or call it directly:

```ruby
require "rekey/rekey"

using Rekey
rows.rekey(:id)

# or
Rekey.rekey(rows, :id)
```


----
