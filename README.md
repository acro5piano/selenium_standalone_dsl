[![Gem Version](https://badge.fury.io/rb/selenium_standalone_dsl.svg)](https://badge.fury.io/rb/selenium_standalone_dsl)

# SeleniumStandaloneDsl

Gem for using Selenium webdriver simply.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'selenium_standalone_dsl'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install selenium_standalone_dsl

## Usage

```rb
class YahooSearcher < SeleniumStandaloneDsl::Base
  def search_wikipedia
    visit 'https://www.yahoo.com/'
    fill_in 'p', with: 'wikipedia'
    click 'IconNavSearch', find_by: :css
    click 'Next'
  end
end

config = {
  log_path: '/tmp/selenium_standalone_dsl.log',
  user_agent: 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.84 Safari/537.36',
  headless: true,
}

driver = YahooSearcher.new(config)
driver.search_wikipedia

# => New firefox instance will start headlessly

```

## Development

    $ git clone git@github.com:acro5piano/selenium_standalone_dsl.git
    $ cd selenium_standalone_dsl
    $ bundle install --path vendor/bundle
    $ bundle exec rake
    
To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/acro5piano/selenium_standalone_dsl. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

