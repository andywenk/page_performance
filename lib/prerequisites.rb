module PagePerformance
  class Prerequisites
    class << self
      def check_prerequisites
        ruby_version
        phantomjs_available
        
        rescue PagePerformance::Error::RubyVersion => e
          puts e.message
          exit
        rescue PagePerformance::Error::Phantomjs => e
          puts e.message
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