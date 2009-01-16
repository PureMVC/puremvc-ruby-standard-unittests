require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the flash_helper plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib/PureMVC_Ruby_1_0'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end