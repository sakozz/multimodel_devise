$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "multiuser_devise/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "multiuser_devise"
  s.version     = MultiuserDevise::VERSION
  s.authors     = ["Sunil Shrestha"]
  s.email       = ["sunil@iwa.fi"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of MultiuserDevise."
  s.description = "TODO: Description of MultiuserDevise."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.3"

  s.add_development_dependency "sqlite3"
end
