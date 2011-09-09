require 'helper'

class TestAPI < Test::Unit::TestCase

  valid_options = {
    :app_name => "Some Application",
    :dev_token => 'developer_token',
    :dev_secret => 'developer_secret',
    :user_token => 'user_token',
    :user_secret => 'user_secret'
  }

  context 'basic api construction' do

    should 'allow construction of an API access object' do
      api = Netflix4Ruby::API.new(valid_options)
      assert_equal valid_options[:app_name], api.app_name
      assert_equal valid_options[:dev_token], api.dev_token
      assert_equal valid_options[:dev_secret], api.dev_secret
      assert_equal valid_options[:user_token], api.user_token
      assert_equal valid_options[:user_secret], api.user_secret
    end

  end

end
