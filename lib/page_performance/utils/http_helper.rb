require 'net/https'
require 'uri'

module PagePerformance
  module Utils
    # helper clas for various HTTP related stuff
    class HttpHelper
      def formated_url(url, options = {})
        uri           = URI.join(options.fetch(:base_url, ''), url)
        uri.user      = options.fetch(:basic_auth_user, nil)
        uri.password  = options.fetch(:basic_auth_password, nil)
        uri.to_s
      end

      def fetch_url(url, options = {}, limit = 10)
        raise PagePerformance::Error::TooManyRedirects if limit == 0
        puts url
        uri = URI.join(options.fetch(:base_url, ''), url)
        req = Net::HTTP::Get.new(uri.request_uri)

        unless options.empty?
          req.basic_auth options.fetch(:basic_auth_user, ''), options.fetch(:basic_auth_password, '')
        end

        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
          http.request(req)
        end

        case response
        when Net::HTTPSuccess then
          response
        when Net::HTTPRedirection then
          location = response['location']
          warn "redirected to #{location}"
          fetch_url(location, options, limit - 1)
        else
          response.value
        end
      end
    end
  end
end