module PagePerformance
  module Output
    class ConsoleWriter
      attr_accessor :url, :request_time

      def initialize
      end

      def self.console(output)
        puts output
      end

      def write_to_console
        puts result_string
      end

      def result_string
        "\s#{url}: #{request_time} ms\n"
      end
    end
  end
end