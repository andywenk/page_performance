module PagePerformance
  class Prerequisites
    class << self
      def check_prerequisites
        ruby_version
        phantomjs_available
        
        rescue PagePerformance::Error::RubyVersion
          puts "wrong ruby version! Should be 1.9.2 or higher"
          exit
        rescue PagePerformance::Error::Phantomjs
          puts "phantomjs is not available. You can get it here: http://code.google.com/p/phantomjs/"
          exit
      end

      def ruby_version
        raise PagePerformance::Error::RubyVersion unless `ruby -v` =~ /1.9.[2 3 4]/
      end

      def phantomjs_available
        raise PagePerformance::Error::Phantomjs unless `which phantomjs` =~ /phantomjs/
      end
    end
  end
end