module MultiuserDevise
  class Engine < ::Rails::Engine
    isolate_namespace MultiuserDevise
    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.stylesheets = false
      g.javascripts = false
      g.views =false
    end
  end
end
