$:.push File.expand_path("../lib", __FILE__)
require 'insightly/version'

Gem::Specification.new do |s|
  s.name = "insightly"
  s.summary = "Insight.ly Ruby Client Library"
  s.description = "Ruby library for integrating with Insight.ly"
  s.version = Insightly::Version::String
  s.author = "r26D"
  s.email = "code@r26d.com"
  s.homepage = "http://www.r26d.com/"
  s.has_rdoc = false
  s.files = Dir.glob ["README.md", "LICENSE", "{lib,spec}/**/*.rb", "lib/**/*.crt", "*.gemspec"]
  s.add_dependency "builder", ">= 2.0.0"
  s.add_dependency "json", ">= 1.7.5"
  s.add_dependency "rest-client", ">=1.6.7"
  s.add_dependency "logger", ">=1.2.8"
end
