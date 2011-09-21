require 'helper'

class TestAPI < Test::Unit::TestCase

  valid_options = {
    :app_name => "Some Application",
    :dev_token => 'developer_token',
    :dev_secret => 'developer_secret',
    :user_token => 'user_token',
    :user_secret => 'user_secret',
    :user_id => 'user_id'
  }

  context 'api construction' do

    should 'allow construction of an API access object' do
      api = Netflix4Ruby::API.new(valid_options[:app_name], valid_options[:dev_token],
                                  valid_options[:dev_secret], valid_options[:user_token],
                                  valid_options[:user_secret], valid_options[:user_id])
      assert_equal valid_options[:app_name], api.app_name
      assert_equal valid_options[:dev_token], api.dev_token
      assert_equal valid_options[:dev_secret], api.dev_secret
      assert_equal valid_options[:user_token], api.user_token
      assert_equal valid_options[:user_secret], api.user_secret
      assert_equal valid_options[:user_id], api.user_id
    end

    should 'allow construction from a YAML file' do
      api = Netflix4Ruby::API.from_file(File.dirname(__FILE__) + '/data/credentials.yml')
      assert_equal "MyApp", api.app_name
      assert_equal "token1", api.dev_token
      assert_equal "secret1", api.dev_secret
      assert_equal "user_token_1", api.user_token
      assert_equal "user_secret_1", api.user_secret
      assert_equal "user_id_1", api.user_id
    end

    should 'raise when constructed with a non-existent YAML file' do
      assert_raise Errno::ENOENT do
        Netflix4Ruby::API.from_file(File.dirname(__FILE__) + '/data/not-credentials.yml')
      end
    end

  end

end
