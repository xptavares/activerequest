# Activerequest

Active Request is a gem to help monolithic projects turn into micro services.

[![Gem Version](https://badge.fury.io/rb/activerequest.svg)](https://badge.fury.io/rb/activerequest)
[![Build Status](https://travis-ci.org/xptavares/activerequest.png)](https://travis-ci.org/xptavares/activerequest)
[![codecov](https://codecov.io/gh/xptavares/activerequest/branch/master/graph/badge.svg)](https://codecov.io/gh/xptavares/activerequest)
[![Code Climate](https://codeclimate.com/github/xptavares/activerequest/badges/gpa.svg)](https://codeclimate.com/github/xptavares/activerequest)
[![Issue Count](https://codeclimate.com/github/xptavares/activerequest/badges/issue_count.svg)](https://codeclimate.com/github/xptavares/activerequest)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activerequest'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerequest

## Installation

```ruby
ActiveRequest.configure do |config|
  config.uri = 'localhost:4567'
  config.api_version = 'v1'
end
```

You can use headers for token.
```ruby
ActiveRequest.configure do |config|
  config.uri = 'localhost:4567'
  config.api_version = 'v1'
  config.headers = { "token" => "*" }
end
```
## Usage

[Examples](https://github.com/xptavares/activerequest/blob/master/examples/README.md)


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/activerequest.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
