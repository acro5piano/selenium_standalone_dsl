require 'spec_helper'

describe SeleniumStandaloneDSL::Base do
  before :all do
    @pid = Process.spawn('bundle e ruby spec/fixtures/app.rb')

    config = {
      log_path: '/tmp/selenium_standalone_dsl.log',
      user_agent: 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 ' +
                  '(KHTML, like Gecko) Chrome/51.0.2704.84 Safari/537.36',
      headless: true,
    }
    @driver = SeleniumStandaloneDSL::Base.new(config)
  end

  after :all do
    @driver.quit
    Process.kill 9, @pid
  end

  it 'visit a site' do
    expect { @driver.visit('http://localhost:4567') }.not_to raise_error
  end

  it 'click a link and follow href' do
    @driver.visit 'http://localhost:4567/click'
    expect { @driver.click('ClickMe') }.not_to raise_error
    expect(@driver.driver.current_url).to eq 'http://localhost:4567/'
  end

  it 'fill_in a input box' do
    @driver.visit 'http://localhost:4567/fill_in'
    expect { @driver.fill_in('input_box', with: 'hoge') }.not_to raise_error
  end

  it 'close alert' do
    @driver.visit 'http://localhost:4567/alert'
    expect { @driver.prompt_ok }.not_to raise_error
  end

  it 'select a value in a select box' do
    @driver.visit 'http://localhost:4567/select'
    expect { @driver.select('an option', from: 'select_box') }.not_to raise_error
    expect { @driver.select('an option', from: 'select_box', find_by: :name) }.not_to raise_error
  end

  it 'determine if the page has the text' do
    @driver.visit 'http://localhost:4567/'
    expect(@driver.has_element?(:text, 'Hello')).to be true
    expect(@driver.has_element?(:text, 'Hogehogehoge')).to be false
    expect(@driver.has_element?(:class, 'title')).to be true
    expect(@driver.has_element?(:class, 'titleIsNotBlank')).to be false
  end

  it 'search with Nokogiri' do
    @driver.visit 'http://localhost:4567/search'
    expect(@driver.search('th:contains("title") + td').inner_html).to eq 'Hello'
  end
end

