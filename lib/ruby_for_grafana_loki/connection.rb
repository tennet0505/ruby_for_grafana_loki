require 'json'
require 'base64'
require 'net/http'
require 'uri'

module RubyForGrafanaLoki
  module Connection
    def self.create(base_url, user_name, password, auth_enabled)
      new(base_url, user_name, password, auth_enabled).connection
    end

    def initialize(base_url, user_name, password, auth_enabled)
      @base_url = URI.parse(base_url)
      @user_name = user_name
      @password = password
      @auth_enabled = auth_enabled
    end

    def connection
      Net::HTTP.new(@base_url.host, @base_url.port).tap do |http|
        http.use_ssl = @base_url.scheme == 'https'
      end
    end

    def post(url, body)
      uri = URI.join(@base_url, url)

      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = 'application/json'
      request.body = JSON.generate(body)

      if @auth_enabled
        request['Authorization'] = "Basic #{base64_encode_credentials(@user_name, @password)}"
      end

      response = connection.request(request)

      if response.is_a?(Net::HTTPSuccess)
        JSON.parse(response.body)
      else
        raise "Failed to make POST request. Response code: #{response.code}, Response body: #{response.body}"
      end
    end

    def base64_encode_credentials(user_name, password)
      credentials = "#{user_name}:#{password}"
      Base64.strict_encode64(credentials)
    end
  end
end
