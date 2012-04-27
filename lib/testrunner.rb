module PagePerformance
  class Testrunner
    def initialize(options)
      @options = options
      @results = {}
      @phantomjs_script = File.expand_path("../../vendor/loadspeed.js", __FILE__)
      @output_writer = OutputWriter.new(@options, @results)
    end

    def run
      abort?
      (1..@options[:repeate] || 1).each do |i|
        @output_writer.write_to_console("round #{i}:\n")
        request_urls
        wait? if i < @options[:repeate].to_i
      end

      rescue PagePerformance::Error::NoUrlToTest => e
        puts e.message
        exit

      if @output_writer.write_to_file?
        @output_writer.write_average_results
        @output_writer.write_tag_count
        @output_writer.write_footer
      end
    end

    private

    def request_urls
      raise PagePerformance::Error::NoUrlToTest if @options[:urls] == nil
      @options[:urls].each do |url|
        request_url(url)
      end
    end

    def request_url(url)
      url = @output_writer.formated_url(url)
      request_time = `phantomjs --ignore-ssl-errors=#{@options[:ignore_ssl_errors]} #{@phantomjs_script} #{url}`.gsub(/\n/,'').to_i
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

    def abort?
      trap("SIGINT") do
        puts "\n*** bye bye and have a nice day ..."
        exit!
      end
    end

    def wait?
      return unless @options[:wait]
      @output_writer.write_to_console("... waiting for #{@options[:wait]} s\n") 
      sleep(@options[:wait].to_i)
    end
  end
end