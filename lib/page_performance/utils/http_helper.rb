require 'net/https'

module PagePerformance
  module Utils
    class HttpHelper
      def formated_url(url)
        case url
        when /^http|https:\/\//
          url
        else
          "http://" + url
        end
      end

      def fetch_url(uri_str, limit = 10)
        raise PagePerformance::Error::TooManyRedirects if limit == 0

        uri = URI(uri_str)
        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
          http.request(Net::HTTP::Get.new(uri.request_uri))
        end

        case response
        when Net::HTTPSuccess then
          response
        when Net::HTTPRedirection then
          location = response['location']
          warn "redirected to #{location}"
          fetch_url(location, limit - 1)
        else
          response.value
        end
      end
    end
  end
end