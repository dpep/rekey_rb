require 'minitest/autorun'

require 'simplecov'
SimpleCov.start do
  add_filter /test/
end

if ENV['CI'] == 'true' || ENV['CODECOV_TOKEN']
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require_relative '../lib/rekey'

# https://gist.github.com/jcasimir/3c687bd5db16a73b4cf3
