module PagePerformance
  module Output
    class Writer
      attr_accessor :url, :request_time

      def initialize(options, results)
        @options = options
        @results = results
        initialize_writer
      end

      def initialize_writer
        if write_to_console?
          @console_writer = ConsoleWriter.new
        end

        if write_to_file?
          @file_writer = FileWriter.new(@options, @results)
          @file_writer.create_result_file
        end

        # add other writer
      end

      def write_result
        if write_to_console?
          @console_writer.url = url
          @console_writer.request_time = request_time
          @console_writer.write_to_console
        end

        if write_to_file?
          @file_writer.url = url
          @file_writer.request_time = request_time
          @file_writer.write_to_file 
        end
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

      def formated_url(url)
        case url
        when /^http|https:\/\//
          url
        else
          "http://" + url
        end
      end
    end
  end
end