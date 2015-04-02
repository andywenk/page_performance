module PagePerformance
  module Output
    # parent class for the various output writer classes
    class Writer
      attr_accessor :url, :request_answer

      def initialize(options, results)
        @options = options
        @results = results
        set_writer
        initialize_writer
      end

      def set_writer
        @write_to_console = write_to_console?
        @write_to_file = write_to_file?
      end

      def initialize_writer
        initialize_console_writer if @write_to_console
        initialize_file_writer if @write_to_file
      end

      def initialize_console_writer
        @console_writer = ConsoleWriter.new
      end

      def initialize_file_writer
        @file_writer = FileWriter.new(@options, @results)
        @file_writer.create_result_file
      end

      def write_result
        write_result_to_console if @write_to_console
        write_result_to_file if @write_to_file
      end

      def write_result_to_console
        @console_writer.url = url
        @console_writer.request_answer = request_answer
        @console_writer.write_to_console
      end

      def write_result_to_file
        @file_writer.url = url
        @file_writer.request_answer = request_answer
        @file_writer.write_to_file
      end

      def write_summary
        @file_writer.write_summary if write_to_file?
      end

      def write_to_file?
        !@options[:output].nil?
      end

      def write_to_console?
        !@options[:quiet]
      end
    end
  end
end