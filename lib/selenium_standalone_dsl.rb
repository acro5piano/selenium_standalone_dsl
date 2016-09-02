require 'selenium_standalone_dsl/version'
require 'selenium_standalone_dsl/base'
require 'logger'
require 'selenium-webdriver'
require 'nokogiri'
require 'headless'


module SeleniumStandaloneDsl
  ROOT_DIR = File.dirname(ENV['BUNDLE_GEMFILE']) || File.expand_path('../../', __FILE__)
end
