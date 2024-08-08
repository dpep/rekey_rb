require "byebug"
require "rspec"
require "simplecov"

SimpleCov.start do
  add_filter "/spec/"
end

if ENV["CI"] == "true" || ENV["CODECOV_TOKEN"]
  require "simplecov_json_formatter"
  SimpleCov.formatter = SimpleCov::Formatter::JSONFormatter
end

# load this gem
gem_name = Dir.glob("*.gemspec")[0].split(".")[0]
require "rekey/rekey"

RSpec.configure do |config|
  # allow "fit" examples
  config.filter_run_when_matching :focus

  config.mock_with :rspec do |mocks|
    # verify existence of stubbed methods
    mocks.verify_partial_doubles = true
  end

  config.register_ordering(:global) do |items|
    randomized = RSpec::Core::Ordering::Random.new(config).order(items)

    # put :before_patch examples first
    randomized.partition { |x| x.metadata[:before_patch] }.flatten
  end

  config.before do |example|
    require gem_name unless example.metadata[:before_patch]
  end
end

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }
