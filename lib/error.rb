module PagePerformance
  module Error
    class RubyVersion < StandardError;end
    class Phantomjs < StandardError;end
    class TooManyRedirects < StandardError;end
  end
end