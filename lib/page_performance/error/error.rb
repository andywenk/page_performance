module PagePerformance
  module Error
    # thrown if the ruby version is lower than 1.9.2
    class RubyVersion < StandardError
      def message
        "wrong ruby version! Should be 1.9.2 or higher"
      end
    end

    # thrown, if phantomjs is not available
    class Phantomjs < StandardError
      def message
        "phantomjs is not available. You can get it here: http://code.google.com/p/phantomjs/"
      end
    end

    # thrown, if in PagePerformance::Utils::HttpHelper#fetch_url are too many redirects
    class TooManyRedirects < StandardError
      def message
        "More than 10 HTTP redirects for #{url}. Continue to next URL ..."
      end
    end

    # thorwn, if no URL to test is given
    class NoUrlToTest < StandardError
      def message
        "Hey - we need at least one URL to test. Use -u URLS or -f FILE"
      end
    end
  end
end