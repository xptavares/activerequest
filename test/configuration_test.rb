require 'test_helper'

class ConfigurationTest < Minitest::Test
  def test_reset_configuration
    assert_equal ActiveRequest.configuration.uri, 'localhost:4567'
    ActiveRequest.reset
    assert_equal ActiveRequest.configuration.uri, nil
    ActiveRequest.configure do |config|
      config.api_version = 'v2'
    end
    assert_equal ActiveRequest.configuration.api_version, 'v2'
    ActiveRequest.reset
    assert_equal ActiveRequest.configuration.api_version, nil
    ActiveRequest.configure do |config|
      config.uri = 'localhost:4567'
      config.api_version = 'v1'
    end
  end
end
