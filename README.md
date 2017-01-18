Rekey
======

Reformat Enumerables into Hashes, using derived keys / values

#### Install
```gem install rekey```


#### Usage
```
require 'rekey'


[ 1, 2, 3 ].rekey {|v| v}
=> { 1 => 1, 2 => 2, 3 => 3 }


[
  { k: 'a', v: 1 },
  { k: 'b', v: 2 },
  { k: 'c', v: 3 },
].rekey :k, :v
=> { 'a' => 1, 'b' => 2, 'c' => 3 }
```
