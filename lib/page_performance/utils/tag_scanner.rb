module PagePerformance
  module Utils
    # helper class for HttpHelper for scanning tags in a HTML document
    class TagScanner < HttpHelper
      attr_accessor :found_tags_for_urls

      def initialize(options)
        @options = options
        @found_tags_for_urls = {}
        fetch_html_from_urls
      end

      private

      def fetch_html_from_urls
        @options[:urls].each do |url|
          begin
            html = fetch_url(formated_url(url))
          rescue PagePerformance::Error::TooManyRedirects => e
            puts e.message
            next
          rescue Net::HTTPBadResponse
            puts "uups ... bad response from #{url} ... better continue"
            next
          end
          count_tags(url, html.body)
        end
      end

      def count_tags(url, html)
        @found_tags_for_urls[url] = {}
        @found_tags_for_urls[url][:script] = tag_occurence('script', html) if @options[:script]
        @found_tags_for_urls[url][:iframe] = tag_occurence('iframe', html) if @options[:iframe]
      end

      def tag_occurence(tag, html)
        html.scan(/<#{tag}[^>]*>/i).size
      end
    end
  end
end