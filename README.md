[![Gem Version](https://badge.fury.io/rb/selenium_standalone_dsl.svg)](https://badge.fury.io/rb/selenium_standalone_dsl)

# Selenium Standalone DSL

Gem for using Selenium webdriver simply.

## Installation

Ensure you have already installed Firefox:

```sh
sudo apt-get install firefox
```

If you want to run firefox headlessly, install Xvfb:

```sh
sudo apt-get install xvfb
```

Add this line to your application's Gemfile:

```ruby
gem 'selenium_standalone_dsl'
```

And then execute:

```sh
bundle
```

Or install it yourself as:

```sh
gem install selenium_standalone_dsl
```

## Usage

```rb
class YahooSearcher < SeleniumStandaloneDsl::Base
  def search_for_wikipedia
    visit 'https://www.yahoo.com/'
    fill_in 'p', with: 'wikipedia'

    # You can declare how to find elements: [class|id|css|xpath]
    click 'IconNavSearch', find_by: :class

    if has_element? :text, 'Next'
      click 'Next'
    end

    # You can use full jQuery CSS selector using 'search'
    puts search('span:contains("results")').inner_text
  end
end

config = {
  log_path: '/tmp/selenium_standalone_dsl.log',
  user_agent: 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 ' +
              '(KHTML, like Gecko) Chrome/51.0.2704.84 Safari/537.36',
  headless: true,
}

driver = YahooSearcher.new(config)
driver.search_for_wikipedia

# => 141,000,000 results

```

## Development

```sh
git clone git@github.com:acro5piano/selenium_standalone_dsl.git
cd selenium_standalone_dsl
bundle install --path vendor/bundle
bundle exec rake install
bundle exec rake spec
```
    
To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Roadmap

I will create `Selenium Spider` after completed `Selenium Standalone DSL`.

`Selenium Spider` aims to scrape websites using JavaScript.

There are a lot of tools such as `mechanize` but they are no longer useful for SPA websites.

## TODO

- [ ] Fix class name. Dsl => DSL
- [ ] Log and config
- [ ] TravisCI

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/acro5piano/selenium_standalone_dsl. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

