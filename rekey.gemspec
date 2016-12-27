$LOAD_PATH.unshift 'lib'
package = Rekey
require "#{package.downcase}/version"


Gem::Specification.new do |s|
  s.name        = package.downcase
  s.version     = package.const_get 'VERSION'
  s.summary     = package.to_s
  s.authors     = ["Daniel Pepper"]
  s.files       = Dir.glob("lib/**/*")
  s.homepage    = "https://github.com/d1hotpep/#{package.downcase}"
  s.license     = 'MIT'
  s.description = <<description
    For turning Arrays into Hashes, with keys computed from the Array
    contents.  Or for rekeying Hashes.

    [ 1, 2, 3 ].rekey {|v| v}
    => { 1 => 1, 2 => 2, 3 => 3 }
description
end
