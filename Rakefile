require 'rake/testtask'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
Rake::TestTask.new do |t|
  t.libs << 'test'
end

task :test do
  Rake::Task['spec'].invoke
  Rake::Task['test'].invoke
end

desc "Run tests"
task :default => :test
