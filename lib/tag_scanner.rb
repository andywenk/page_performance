module PagePerformance
  class TagScanner
    attr_accessor :found_tags_for_urls

    def initialize(options)
      @options = options
      @found_tags_for_urls = {}
      fetch_html_from_urls
    end

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

      response = Net::HTTP.get_response(URI(uri_str))

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