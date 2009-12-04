require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'load_multi_rails_rake_tasks'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the test_spec_on_rails plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the test_spec_on_rails plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ResponseVisualizer'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "test_spec_on_rails"
    gemspec.summary = "Provides helpers to test your Rails app using test/spec."
    gemspec.description = "Provides helpers to test your Rails app using test/spec."
    gemspec.email = "pelargir@gmail.com"
    gemspec.homepage = "http://github.com/pelargir/test_spec_on_rails"
    gemspec.authors = ["Matthew Bass"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
