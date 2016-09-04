# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'selenium_standalone_dsl/version'

Gem::Specification.new do |spec|
  spec.name          = "selenium_standalone_dsl"
  spec.version       = SeleniumStandaloneDsl::VERSION
  spec.authors       = ["gosho-kazuya"]
  spec.email         = ["ketsume0211@gmail.com"]

  spec.summary       = %q{Gem for using Selenium webdriver simply}
  spec.description   = %q{Gem for using Selenium webdriver simply}
  spec.homepage      = "https://github.com/acro5piano/selenium_standalone_dsl"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.test_files    = `git ls-files -- spec/*_spec.rb`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'selenium-webdriver'
  spec.add_runtime_dependency 'nokogiri'
  spec.add_runtime_dependency 'headless'

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "sinatra"
  spec.add_development_dependency "pry"
end
