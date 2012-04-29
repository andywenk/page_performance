module PagePerformance
  module Error
    class RubyVersion < StandardError
      def message
        "wrong ruby version! Should be 1.9.2 or higher"
      end
    end

    class Phantomjs < StandardError
      def message
        "phantomjs is not available. You can get it here: http://code.google.com/p/phantomjs/"
      end
    end

    class TooManyRedirects < StandardError
      def message
        "More than 10 HTTP redirects for #{url}. Continue to next URL ..."
      end
    end

    class NoUrlToTest < StandardError
      def message
        "Hey - we need at least one URL to test. Use -u URLS or -f FILE"
      end
    end
  end
end