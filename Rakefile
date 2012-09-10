require "rubygems"
require "rspec/core/rake_task"
require "rake/task"
require File.dirname(__FILE__) + "/lib/insightly/configuration.rb"
#require File.dirname(__FILE__) + "/lib/insightly/version.rb"

task :default => :spec

task :dev_console do
  sh "irb -I lib -rubygems -r insightly"
end

desc "Run units"
RSpec::Core::RakeTask.new('spec')


desc "Build the gem"
task :gem => :clean do
  exec('gem build insightly.gemspec')
end

desc "Push the gem out to rubygems"
task :push_gem => :gem do 
  exec("gem push insightly-#{Insightly::Version::String}.gem")
end


desc 'Cleans generated files'
task :clean do
  rm_f Dir.glob('*.gem').join(" ")
  rm_rf "rdoc"
end

