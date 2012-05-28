module PagePerformance
  module Utils
    # rename the output file if it already exists.
    # example:
    #   first time -> output_file_name
    #   second time -> output_file_name.1
    #   third_time -> output_file_name.2
    class FileRenamer
      def initialize(file_name)
        @file_name = file_name
      end

      def rename
        @path_parts = calculate_path_parts
        new_file = new_file_with_path
        if File.exist?(new_file)
          @file_name = new_file
          new_file = rename
        end
        new_file
      end

      def calculate_path_parts
        parts = @file_name.split('/')
        parts = parts.collect { | item | item unless item == "" }
        parts.compact
      end

      def new_file_with_path
        file_name_parts = calculate_file_name_parts
        new_number = file_name_parts[1].to_i + 1
        new_file_name = [file_name_parts[0], new_number].join('.')
        ["/", @path_parts, new_file_name].join('/')
      end

      def calculate_file_name_parts
        old_file_name = @path_parts.slice!(-1)
        file_name_parts = old_file_name.split('.')
      end
    end
  end
end