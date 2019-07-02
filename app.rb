require 'capybara'
require 'selenium-webdriver'

Capybara.configure do |capybara_config|
  capybara_config.default_driver = :selenium_chrome
end

Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('headless')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :selenium_chrome

capy_bara = Capybara::Session.new(:selenium_chrome)
capy_bara.visit('https://www.yahoo.co.jp/')
capy_bara.save_screenshot('screenshot.png')
