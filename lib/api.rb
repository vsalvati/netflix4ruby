module Netflix4Ruby

  class API

    attr_accessor :app_name, :dev_token, :dev_secret, :user_token, :user_secret

    def initialize options = {}
      raise ArgumentError, 'Must supply dev_token' unless options.has_key? :dev_token
      raise ArgumentError, 'Must supply dev_secret' unless options.has_key? :dev_secret
      raise ArgumentError, 'Must supply user_token' unless options.has_key? :user_token
      raise ArgumentError, 'Must supply user_secret' unless options.has_key? :user_secret

      @app_name = options[:app_name] || 'Unknown Application'
      @dev_token = options[:dev_token]
      @dev_secret = options[:dev_secret]
      @user_token = options[:user_token]
      @user_secret = options[:user_secret]

    end

    def title_search term, options = {}
      response = access_token.get "/catalog/titles?term=#{term}"
      Netflix4Ruby::Builders::CatalogTitleBuilder.from_text response.body
    end

    def instant_queue user_id, options = {}
      options = { :max_results => '100' }.merge options
      response = access_token.get "/users/#{user_id}/queues/instant?max_results=#{options[:max_results]}"
    end

    private

    def access_token
      OAuth::AccessToken.from_hash create_consumer,
                                   :oauth_token => user_token,
                                   :oauth_token_secret => user_secret
    end

    def create_consumer
      OAuth::Consumer.new dev_token,
                          dev_secret,
                          :site => "http://api.netflix.com",
                          :request_token_url => "http://api.netflix.com/oauth/request_token",
                          :access_token_url => "http://api.netflix.com/oauth/access_token",
                          :authorize_url => "https://api-user.netflix.com/oauth/login"
    end

  end

end
