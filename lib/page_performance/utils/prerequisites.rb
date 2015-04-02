module PagePerformance
  module Utils
    # check if everything in the environment is available to start the program
    class Prerequisites
      class << self
        def check_prerequisites
          ruby_version
          phantomjs_available
        end

        def ruby_version
          raise PagePerformance::Error::RubyVersion unless `ruby -v` =~ /2.2.*/
        end

        def phantomjs_available
          raise PagePerformance::Error::Phantomjs unless `which phantomjs` =~ /phantomjs/
        end
      end
    end
  end
end