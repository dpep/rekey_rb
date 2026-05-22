require_relative "lib/rekey/version"

Gem::Specification.new do |s|
  s.name        = "rekey"
  s.version     = Rekey::VERSION
  s.authors     = ["Daniel Pepper"]
  s.summary     = "Rekey"
  s.description = "Reformat Enumerables into Hashes, using derived keys / values"
  s.homepage    = "https://github.com/dpep/rekey_rb"
  s.license     = "MIT"
  s.files       = `git ls-files * ":!:spec"`.split("\n")

  s.required_ruby_version = ">= 3"

  s.add_runtime_dependency "pluckit"

  s.add_development_dependency "debug"
  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"
end
