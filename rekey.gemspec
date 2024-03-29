package_name = File.basename(__FILE__).split(".")[0]
require "./lib/#{package_name}/version"

package = Rekey

Gem::Specification.new do |s|
  s.name        = package_name
  s.version     = package.const_get "VERSION"
  s.authors     = ["Daniel Pepper"]
  s.summary     = package.to_s
  s.description = "Reformat Enumerables into Hashes, using derived keys / values"
  s.homepage    = "https://github.com/dpep/#{package_name}_rb"
  s.license     = "MIT"
  s.files       = `git ls-files * ":!:spec"`.split("\n")

  s.required_ruby_version = ">= 3"

  s.add_runtime_dependency "pluckit"

  s.add_development_dependency "byebug"
  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"
end
