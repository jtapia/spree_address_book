# SolidusAddressBook

[![Build Status](https://travis-ci.org/jtapia/solidus_address_book.svg?branch=master)](https://travis-ci.org/jtapia/solidus_address_book)

This extension allows registered users to have multiple shipping & billing addresses and select each of them on checkout.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'solidus_address_book', github: 'jtapia/solidus_address_book'
```

Then run the following:

```console
$ bundle install
$ bundle exec rails g solidus_address_book:install
```

## Testing

Run the following to automatically build a dummy app and run the tests:

```console
$ bundle exec rake
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jtapia/solidus_address_book.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
