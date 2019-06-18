# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = 'solidus_address_book'
  s.version = '3.2.0.alpha'
  s.summary = 'Adds address book for users to Spree'
  s.description = s.summary

  s.required_ruby_version = '>= 2.1.2'

  s.author = 'Roman Smirnov'
  s.email = 'POMAHC@gmail.com'
  s.homepage = 'http://github.com/magma-labs/solidus_address_book'

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.files = Dir["{app,config,db,lib}/**/*", 'LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'solidus', ['>= 2.0', '< 3']
  s.add_dependency 'solidus_auth_devise', ['>= 2.0', '< 3']
  s.add_dependency 'solidus_support'
  s.add_dependency 'deface', '~> 1.0'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara-screenshot'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_bot'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-rspec'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end
