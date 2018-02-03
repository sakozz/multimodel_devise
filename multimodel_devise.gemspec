$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "multimodel_devise/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "multimodel_devise"
  s.version     = MultimodelDevise::VERSION
  s.authors     = ["Sunil Shrestha"]
  s.email       = ["sunil@iwa.fi"]
  s.homepage    = "http://github.com"
  s.summary     = " Summary of MultiuserDevise."
  s.description = "Description of MultiuserDevise."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0.rc1"
  s.add_dependency 'active_model_serializers', '~> 0.10.0'
  s.add_dependency "pundit"
  s.add_dependency "devise"

  s.add_development_dependency "sqlite3"
end
