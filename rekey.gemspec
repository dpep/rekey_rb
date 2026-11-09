require_relative "lib/rekey/version"

Gem::Specification.new do |s|
  s.authors     = ["Daniel Pepper"]
  s.description = "Reformat Enumerables into Hashes, using derived keys / values"
  s.files       = `git ls-files * ':!:spec'`.split("\n")
  s.homepage    = "https://github.com/dpep/rekey_rb"
  s.license     = "MIT"
  s.name        = "rekey"
  s.summary     = s.description
  s.version     = Rekey::VERSION

  s.metadata = {
    "changelog_uri" => "#{s.homepage}/blob/main/CHANGELOG.md",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => s.homepage,
  }

  s.required_ruby_version = ">= 3.2"

  s.add_dependency "pluckit", ">= 1.3"

  s.add_development_dependency "debug"
  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov", ">= 1"
end
