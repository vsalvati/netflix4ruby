require 'helper'

class TestAPI < Test::Unit::TestCase

  context 'basic api construction' do

    should 'allow construction of an API access object' do
      api = Netflix4Ruby::API.new(:app_name => 'My Application')
      assert_equal 'My Application', api.app_name
    end

  end

end
