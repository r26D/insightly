require "rubygems"
require "rspec/core/rake_task"
require "rake/task"
require File.dirname(__FILE__) + "/lib/insightly/configuration.rb"
require File.dirname(__FILE__) + "/lib/insightly/version.rb"

task :default => :spec

task :dev_console do
  sh "irb -I lib -rubygems -r insightly"
end

desc "Run units"
RSpec::Core::RakeTask.new('spec')


desc "Build the gem"
task :gem => :clean do
  system 'gem build insightly.gemspec'
end

desc "Push the gem out to rubygems"
task :push_gem => :gem do 
  system "gem push insightly-#{Insightly::Version::String}.gem"
  Rake::Task[:tag_version].invoke
end

desc "Tags the current version of the code"
task :tag_version do
  system "git tag -a v#{Insightly::Version::String} -m 'Version #{Insightly::Version::String} Published #{Date.today.strftime("%b/%d/%Y")}' "
  system "git push origin --tags"
end

desc "Clean out VCR cache"
task :clean_vcr do
  puts "purging VCR cache"
  rm_f Dir.glob("spec/unit/cassettes/*.yml")
end
desc 'Cleans generated files'
task :clean do
  rm_f Dir.glob('*.gem').join(" ")
  rm_rf "rdoc"
end

