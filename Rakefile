# frozen_string_literal: true

require 'rubygems/package_task'
require 'rake/testtask'

task default: :test

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/test_*.rb']
  t.verbose = true
end

spec = Gem::Specification.load("#{__dir__}/treerful_scanner.gemspec")
Gem::PackageTask.new(spec).define
