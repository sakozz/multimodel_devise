# MultimodelDevise
Rails engine that implements devise multi-model and provides basic authentication and authorization via API.
Ths engine is useful when 
1. You have two different user models. i.e. Admin user and end-users
2. You want to authenticate user via API with authentication token.

This engine implements basic token authentication and authorization.


## Installation
####Option 1. You can clone the engine to your project and start to make modifications if needed

1 Go to folder where you want to clone
```ruby
cd my_project/vendor
```
2 Clone the engine

```ruby
git clone git@github.com:sunil-shrestha/multimodel_devise.git
```

3 Reference the engine as gem inside your gemfile
```ruby
gem 'multimodel_devise', path: './vendor/multimodel_devise'
```

####Option 2. Use it as gem from github

Add this line to your application's Gemfile:

```ruby
gem 'multimodel_devise', git: 'https://github.com/sunil-shrestha/multimodel_devise'
```

And then execute:
```bash
$ bundle
```



## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
