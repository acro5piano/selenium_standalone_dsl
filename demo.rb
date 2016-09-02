require 'bundler/setup'
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
