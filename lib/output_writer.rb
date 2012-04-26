module PagePerformance
  class OutputWriter
    def initialize(options, results)
      @options = options
      @results = results
      create_result_file
    end

    def write_to_file?
      !@options[:output].nil?
    end

    def create_result_file
      return unless @options[:output]
      file = File.expand_path("../../#{@options[:output]}", __FILE__)
      @result_file = File.new(file,  "w+")
      @result_file.write(file_header)
    end

    def write_to_console(output)
      puts output unless @options[:quiet]
    end

    def write_result(url, request_time)
      result = "\s#{url}: #{request_time} ms\n"
      write_to_console(result)    
      write_to_file(result) if write_to_file?
    end

    def write_to_file(result)
      @result_file.write(result)
    end

    def write_average_results
      return unless @result_file
      out = "\nAverage load time time:\n---------------------\n"
      @results.each do | url, times |
        out += "\s#{url}: #{calculate_average_load_time(times)} ms\n"
      end
      @result_file.write(out)
    end

    def write_tag_count
      return unless @options[:scan_tags]
      tag_scanner = TagScanner.new(@options)
      found_tags = tag_scanner.found_tags_for_urls
      out = "\nAmount of Tags found per URL:\n-----------------------------\n"
      found_tags.each do | url, tags |
        out += "\s#{url}:\n"
        tags.each do | tag, amount |
          out += "\s\s\s#{tag}: #{amount}\n"
        end
      end
      @result_file.write(out)
    end

    def write_footer
      @result_file.write("\nTest ended at: #{Time.now}")
    end

    def formated_url(url)
      case url
      when /^http|https:\/\//
        url
      else
        "http://" + url
      end
    end

    private

    def calculate_average_load_time(times)
      count = times.length
      sum = 0
      times.each { |time| sum += time }
      sum / count
    end

    def file_header
      text = <<END
PagePerformance test results
============================

Test started at: #{Time.now}

Results for performance tests for the following URLs:

#{url_list}

Results:
--------
END
    end

    def url_list
      out = ""
      @options[:urls].each do | url | 
        out += "\s+ #{url}\n" 
      end
      out
    end
  end
end