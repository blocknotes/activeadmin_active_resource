# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:each, type: :system) do
    # driven_by(:selenium_chrome_headless)
    driven_by(:rack_test)
  end
end
