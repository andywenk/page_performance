require './lib/output_writer'

module PagePerformance
  class Testrunner
    def initialize(options)
      @options = options
      @results = {}
      @phantomjs_script = File.expand_path("../../vendor/loadspeed.js", __FILE__)
      @output_writer = OutputWriter.new(@options, @results)
    end

    def run
      @output_writer.create_result_file
      (1..@options[:repeate] || 1).each do |i|
        @output_writer.write_to_console("round #{i}:\n")
        request_urls
      end
      @output_writer.write_average_results
    end

    def request_urls
      @options[:urls].each do |url|
        request_url(url)
      end
    end

    def request_url(url)
      url = @output_writer.formated_url(url)
      request_time = `phantomjs #{@phantomjs_script} #{url}`.gsub(/\n/,'').to_i
      add_to_results_hash(url, request_time)
      @output_writer.write_result(url, request_time)
    end

    def add_to_results_hash(url, request_time)
      if @results.has_key?(url) 
        @results[url] << request_time
        return
      end
      @results[url] = [request_time]
    end
  end
end