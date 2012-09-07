require "rubygems"
require "rspec/core/rake_task"
require "rake/task"

task :default => :spec

task :dev_console do
  sh "irb -I lib -rubygems -r insightly"
end

desc "Run units"
RSpec::Core::RakeTask.new('spec')


task :gem do
  exec('gem build insightly.gemspec')
end

require File.dirname(__FILE__) + "/lib/insightly/configuration.rb"

desc 'Cleans generated files'
task :clean do
  rm_f Dir.glob('*.gem').join(" ")
  rm_rf "rdoc"
  rm_rf "bt_rdoc"
end
