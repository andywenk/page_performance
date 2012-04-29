module PagePerformance
  module Base
    class Run
      def initialize(options)
        @options = options
        @results = {}
        @phantomjs_script = File.expand_path("../../../../vendor/loadspeed.js", __FILE__)
        @output_writer = Output::Writer.new(@options, @results)
      end

      def run
        abort?
        (1..@options[:repeate] || 1).each do |i|
          Output::ConsoleWriter.console("round #{i}:\n")
          request_urls
          wait? if i < @options[:repeate].to_i
        end

        @output_writer.write_summary
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
        @output_writer.url = url
        @output_writer.request_time = request_time
        @output_writer.write_result
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
        Output::ConsoleWriter.console("... waiting for #{@options[:wait]} s\n") 
        sleep(@options[:wait].to_i)
      end
    end
  end
end