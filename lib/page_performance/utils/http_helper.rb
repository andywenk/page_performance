require 'net/https'
require 'uri'

module PagePerformance
  module Utils
    # helper clas for various HTTP related stuff
    class HttpHelper
      def formated_url(url, base_url='')
        URI.join(base_url, url)
      end

      def fetch_url(uri_str, options = nil, limit = 10)
        puts options
        raise PagePerformance::Error::TooManyRedirects if limit == 0

        uri = URI(uri_str)
        req = Net::HTTP::Get.new(uri.request_uri)

        unless options.nil?
          req.basic_auth options[:user], options[:pass]
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