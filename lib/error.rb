module PagePerformance
  module Error
    class RubyVersion < StandardError;end
    class Phantomjs < StandardError;end
    class TooManyRedirects < StandardError;end
    class NoUrlToTest < StandardError;end
  end
end