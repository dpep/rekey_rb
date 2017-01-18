$LOAD_PATH.unshift 'lib'
package_name = 'rekey'
require "#{package_name}"
require "#{package_name}/version"
package = const_get package_name.capitalize


Gem::Specification.new do |s|
  s.name        = package_name
  s.version     = package.const_get 'VERSION'
  s.authors     = ['Daniel Pepper']
  s.summary     = package.to_s
  s.description = 'Reformat Enumerables into Hashes, using derived keys / values'
  s.homepage    = "https://github.com/d1hotpep/#{package_name}"
  s.license     = 'MIT'

  s.files       = Dir.glob('lib/**/*')
  s.test_files  = Dir.glob('test/**/test_*')
  s.add_development_dependency 'rake', '~> 10'
end
