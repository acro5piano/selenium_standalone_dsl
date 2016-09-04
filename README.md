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
require 'selenium_standalone_dsl'

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


## Supported API

| Method   | Summary                           | Arguments                | Remarks                        |
|----------|-----------------------------------|--------------------------|--------------------------------|
| click    | Click a button or link            | text of link, name, etc. |                                |
| select   | Choose an option in select box    | option text              |                                |
| visit    | Navigate firefox to a link        |                          |                                |
| fill\_in | Fill in a input box               | element name             |                                |
| search   | Search page source using Nokogiri |                          | Returns Nokogiri::XML::Element |

### Options

| Name      | Argument                                      | Defalut     |
|-----------|-----------------------------------------------|-------------|
| :find\_by | :link\_text, :name, :id, :class, :css, :xpath | :link\_text |




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

I will create `Selenium Spider` after completing `Selenium Standalone DSL`.

`Selenium Spider` aims to scrape websites using JavaScript.

There are a lot of tools such as `mechanize` but they are no longer useful for SPA websites.

In my heart, `Selenium Spider` will have these features:

### Full JavaScript support

Based on Selenium Standalone DSL which run Firefox headlessly, it comprehences JavaScript completely.

### PMC architecture

PMC = Pagination Model Controller

Generally, scraping is consist of two parts: Listing page and Detail page.

In PMC architecture, Page is for listing items and pagenation.

Model is for extracting information from detail page and store data to database.

Controller is for handling the above two.

### Web-based task execution

Scraping tasks are often multiply and difficult to arrange.

Imagine Web-based task execution, definition, csv-export and scheduling like Jenkins.

## TODO

- [x] Fix module name. Dsl => DSL
- [x] Defalut config
- [x] Add API document
- [ ] TravisCI
- [ ] Log

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/acro5piano/selenium_standalone_dsl. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

