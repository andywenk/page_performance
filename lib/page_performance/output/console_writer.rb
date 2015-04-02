module PagePerformance
  module Output
    # generates output for the console
    class ConsoleWriter
      result =
      attr_accessor :url, :request_answer

      def initialize
      end

      def self.console(output)
        puts output
      end

      def write_to_console
        puts result_string
      end

      def result_string
        result = request_answer.to_i.is_a?(Fixnum) ? "#{request_answer} ms" : request_answer
        "\s#{url}: #{result}\n"
      end
    end
  end
end