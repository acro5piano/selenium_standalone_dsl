module SeleniumStandaloneDsl
  class Base
    attr_reader :driver

    # @param  Hash config
    #         config = {
    #             log_path: '/path/to/logs',
    #             user_agent: 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.84 Safari/537.36',
    #         }
    def initialize(config)
      # Initialize instance variables
      @config = config
      @logger = Logger.new(@config[:log_path])

      # Extends timeout
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.timeout = 120

      # Create profile so that each driver instance has its own cookie
      profile = Selenium::WebDriver::Firefox::Profile.new
      profile['general.useragent.override'] = @config[:user_agent]
      profile.native_events = true

      if @config[:headless]
        headless = Headless.new(reuse: false, destroy_at_exit: true)
        headless.start
      end

      @driver = Selenium::WebDriver::Driver.for(:firefox, :http_client => client, :profile => profile)

      @logger.info '=' * 150
      @logger.info 'SeleniumStandaloneDsl started'
    end

    # The following methods are utility methods for SeleniumStandaloneDsl-DSL.
    # You can easily handle driver with this DSL.
    def click(selector, find_by: :link_text)
      sleep Random.new.rand(1..2)
      with_frame do
        @driver.find_element(find_by, selector).click
      end
      sleep Random.new.rand(1..2)
    end

    def popup
      @driver.switch_to.window @driver.window_handles.last
      yield
      @driver.switch_to.window @driver.window_handles.first
    end

    def fill_in(selector, find_by: :name, with: nil)
      return if !with

      element = @driver.find_element(find_by, selector)
      0.upto(100) { element.send_keys "\b" }
      element.send_keys with
    end

    def prompt_ok
      @driver.switch_to.alert.accept
    end

    def select(text, from: nil, find_by: :name)
      return if !from

      # For legacy sites using Frame
      element = with_frame do
        @driver.find_element(find_by, from)
      end
      select = Selenium::WebDriver::Support::Select.new(element)
      select.select_by :text, text
    end

    def has_element?(method, selector)
      if method == :text
        @driver.page_source.match(selector) != nil
      else
        begin
          @driver.find_element(method, selector).is_a? Selenium::WebDriver::Element
        rescue Selenium::WebDriver::Error::NoSuchElementError
          false
        end
      end
    end

    # Provide jQuery-like search using Nokogiri::HTML
    # @return Array of [Selenium::WebDriver::Element]
    def search(selector)
      Nokogiri::HTML.parse(@driver.page_source).search selector
    end

    def iframe(method, selector)
      current_frame = @driver.window_handles.first
      @driver.switch_to.frame @driver.find_element(method, selector)
      yield
      # Frame might has gone away
      @driver.switch_to.frame current_frame rescue Selenium::WebDriver::Error::NoSuchFrameError
    end

    def with_frame(&block)
      begin
        block.call
      rescue Selenium::WebDriver::Error::NoSuchElementError
        begin
          @driver.switch_to.frame 1
        rescue Selenium::WebDriver::Error::NoSuchFrameError
          raise Selenium::WebDriver::Error::NoSuchElementError
        end
        block.call
      end
    end

    def visit(url)
      @driver.get url
    end

    def quit
      @driver.quit
      if @config[:headless]
        headless = Headless.new(reuse: false, destroy_at_exit: true)
        headless.start
      end
    end
  end
end

