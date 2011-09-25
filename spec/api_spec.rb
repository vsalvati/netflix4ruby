require 'spec_helper'

describe Netflix4Ruby::API do

  it 'should allow construction via parameters' do
    api = Netflix4Ruby::API.new("Some Application", "dev_token", "dev_secret",
                                "user_token", "user_secret", "user_id")
    api.app_name.should == 'Some Application'
    api.dev_token.should == 'dev_token'
    api.dev_secret.should == 'dev_secret'
    api.user_token.should == 'user_token'
    api.user_secret.should == 'user_secret'
    api.user_id.should == 'user_id'
  end

  it 'should allow construction from a YAML file' do
    api = Netflix4Ruby::API.from_file(File.dirname(__FILE__) + '/data/credentials.yml')
    api.app_name.should == 'MyApp'
    api.dev_token.should == "token1"
    api.dev_secret.should == "secret1"
    api.user_token.should == "user_token_1"
    api.user_secret.should == "user_secret_1"
    api.user_id.should == "user_id_1"
  end

  it 'should raise when constructed with a non-existent YAML file' do
    lambda {
      Netflix4Ruby::API.from_file(File.dirname(__FILE__) + '/data/not-credentials.yml')
    }.should raise_error(Errno::ENOENT)
  end

end
