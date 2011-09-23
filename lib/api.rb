module Netflix4Ruby

  class API

    attr_accessor :app_name, :dev_token, :dev_secret, :user_token, :user_secret, :user_id

    def self.from_file(file_path)
      config = YAML.load_file(file_path)
      API.new(config["application_name"], config["developer_token"], config["developer_secret"],
              config["user_token"], config["user_secret"], config["user_id"])
    end

    def initialize(application_name, developer_token, developer_secret, user_token, user_secret, user_id)
      @app_name = application_name
      @dev_token = developer_token
      @dev_secret = developer_secret
      @user_token = user_token
      @user_secret = user_secret
      @user_id = user_id
    end

    def add_catalog_title(title_ref)
      body = post "/users/#{user_id}/queues/instant?title_ref=#{title_ref}"

      Netflix4Ruby::Builders::QueueItemBuilder.from_text(body).first
    end

    def delete_item(id, type)
      body = delete "/users/#{user_id}/queues/instant/#{type}/#{id}"

      puts body
      Netflix4Ruby::Builders::QueueItemBuilder.from_text(body).first
    end

    def instant_queue(options = {})
      options = { :max_results => '100' }.merge options
      body = get "/users/#{user_id}/queues/instant?max_results=#{options[:max_results]}"

      Netflix4Ruby::Builders::QueueItemBuilder.from_text body
    end

    def title_search(term, start_index = 0, max_results = 25)
      body = get "/catalog/titles", { 'term' => term.to_s,
                                      'start_index' => start_index.to_s,
                                      'max_results' => max_results.to_s }

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

    def delete(uri)
      response = access_token.delete uri
      case response
        when Net::HTTPSuccess
          response.body
        else
          response.error!
      end
    end

    def get(uri, params = {})
      response = access_token.request :get, uri, params
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
