Rekey
======

Reformat Enumerables into Hashes, using derived keys / values

#### Install
```gem install rekey```


#### Usage
```
require 'rekey'

# key a list of records by id
[
  { id: 1, name: 'alice', age: 30},
  { id: 2, name: 'bob', age: 24},
  { id: 3, name: 'charlie', age: 88},
].rekey :id
=> {
  1 => { id: 1, name: 'alice', age: 30},
  2 => { id: 2, name: 'bob', age: 24},
  3 => { id: 3, name: 'charlie', age: 88},
}


# create an id => value map from a list of records
[
  { id: 1, name: 'alice', age: 30},
  { id: 2, name: 'bob', age: 24},
  { id: 3, name: 'charlie', age: 88},
].rekey :id, :name
=> {
  1 => 'alice',
  2 => 'bob',
  3 => 'charlie'
}


# or use blocks
[ 2, 4, 6 ].rekey {|v| v / 2}
=> { 
  1 => 2,
  2 => 4,
  3 => 6
}
```
