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

    def add_title(title_ref)
      body = post "/users/#{user_id}/queues/instant", { 'title_ref' => title_ref.to_s }
      Netflix4Ruby::Builders::QueueBuilder.from_text(body).first
    end

    def remove_title(id, type)
      body = delete "/users/#{user_id}/queues/instant/#{type}/#{id}"
      Netflix4Ruby::Builders::QueueBuilder.from_text(body).first
    end

    def formats_for(catalog_title)
      # TODO verify title has formats_href first?
      body = get catalog_title.formats_href
      Netflix4Ruby::Builders::DeliveryFormatsBuilder.from_text(body)
    end

    # sort options: :queue_sequence, :date_added, :alphabetical
    def instant_queue(options = {})
      allowed_options = [ :sort, :start_index, :max_results ]
      params = options.select { |k, v| allowed_options.include?(k) }
      body = get "/users/#{user_id}/queues/instant", params
      Netflix4Ruby::Builders::QueueBuilder.from_text body
    end

    def title_search(term, options = {})
      allowed_options = [ :start_index, :max_results ]
      params = { 'term' => term }.merge!(options.select { |k, v| allowed_options.include?(k) })
      body = get "/catalog/titles", params
      Netflix4Ruby::Builders::CatalogTitlesBuilder.from_text body
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

    def delete(uri, params = {})
      response = access_token.request :delete, uri, params
      case response
        when Net::HTTPSuccess
          response.body
        else
          response.error!
      end
    end

    def get(uri, params = {})

      param_array = []
      params.each { |k, v| param_array << "#{k}=#{CGI.escape(v.to_s)}" }
      param_string = param_array.empty? ? '' : "?#{param_array.join('&')}"

      response = access_token.request :get, "#{uri}#{param_string}"
      case response
        when Net::HTTPSuccess
          response.body
        else
          response.error!
      end

    end

    def post(uri, params = {})
      response = access_token.request :post, uri, params
      case response
        when Net::HTTPSuccess
          response.body
        else
          response.error!
      end
    end

  end

end
