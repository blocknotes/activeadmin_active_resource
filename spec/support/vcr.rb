# frozen_string_literal: true

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.configure_rspec_metadata!
  config.default_cassette_options = { record: :new_episodes }
  config.hook_into :webmock

  config.ignore_request do |request|
    ['/__identify__', '/json/version'].include? URI(request.uri).path
  end
end
