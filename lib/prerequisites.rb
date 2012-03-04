module PagePerformance
  require './lib/exception'

  class Prerequisites
    def self.check_prerequisites
      ruby_version
      phantomjs_available
      
      rescue PerformanceTestError::RubyVersion
        puts "wrong ruby version! Should be 1.9.2 or higher"
        exit
      rescue PerformanceTestError::Phantomjs
        puts "phantomjs is not available. You can get it here: http://code.google.com/p/phantomjs/"
        exit
    end

    def self.ruby_version
      raise PerformanceTestError::RubyVersion unless `ruby -v` =~ /1.9.[2 3 4]/
    end

    def self.phantomjs_available
      raise PerformanceTestError::Phantomjs unless `which phantomjs` =~ /phantomjs/
    end
  end
end