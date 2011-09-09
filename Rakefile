# encoding: utf-8
require './lib/version.rb'

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "netflix4ruby"
  gem.homepage = "http://github.com/aramis/netflix4ruby"
  gem.license = "MIT"
  gem.summary = %Q{Netflix API for Ruby}
  gem.description = %Q{Access the Netflix API using Ruby}
  gem.email = "nveys@aramisgroup.com"
  gem.authors = ["Nick Veys"]
  gem.version = Netflix4Ruby::Version::STRING
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = Netflix4Ruby::Version::STRING

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "netflix4ruby #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
