module Netflix4Ruby

  class API

    attr_accessor :app_name, :dev_token, :dev_secret, :user_token, :user_secret

    def initialize(application_name, developer_tokenz, developer_secretz, user_tokenz, user_secretz)
      @app_name = application_name
      @dev_token = developer_tokenz
      @dev_secret = developer_secretz
      @user_token = user_tokenz
      @user_secret = user_secretz
    end

    def add_catalog_title(user_id, title_ref)
      body = post "/users/#{user_id}/queues/instant?title_ref=#{title_ref}"

      Netflix4Ruby::Builders::QueueItemBuilder.from_text(body).first
    end

    def instant_queue(user_id, options = {})
      options = { :max_results => '100' }.merge options
      body = get "/users/#{user_id}/queues/instant?max_results=#{options[:max_results]}"

      Netflix4Ruby::Builders::QueueItemBuilder.from_text body
    end

    def title_search(term, options = {})
      body = get "/catalog/titles?term=#{term}"

      Netflix4Ruby::Builders::CatalogTitleBuilder.from_text body
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

    def get(uri)
      response = access_token.get uri
      case response
        when Net::HTTPSuccess
          response.body
        else
          response.error!
      end
    end

    def post(uri)
      response = access_token.post uri
      case response
        when Net::HTTPSuccess
          response.body
        else
          response.error!
      end
    end

  end

end
