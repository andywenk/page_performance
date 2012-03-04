module PagePerformance
  class OutputWriter
    def initialize(options, results)
      @options = options
      @results = results
    end

    def create_result_file
      return unless @options[:output]
      file = File.expand_path("../../#{@options[:output]}", __FILE__)
      @result_file = File.new(file,  "w+")
    end

    def write_to_console(output)
      puts output unless @options[:quiet]
    end

    def write_result(url, request_time)
      result = "#{url}: #{request_time} ms\n"
      write_to_console(result)    
      write_to_file(result)
    end

    def write_to_file(result)
      @result_file.write(result) if @result_file
    end

    def write_average_results
      return unless @result_file
      out = "\nAverage request time:\n"
      @results.each do | url, times |
        out += "#{url}: #{average(times)} ms\n"
      end
      @result_file.write(out)
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

    def average(times)
      count = times.length
      sum = 0
      times.each { |time| sum += time }
      sum / count
    end
  end
end