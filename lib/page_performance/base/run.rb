module PagePerformance
  module Base
    # this is the basic page_performance object
    class Run
      def initialize(options)
        @options = options
        @results = {}
        @phantomjs_script = File.expand_path("../../../../vendor/loadspeed.js", __FILE__)
        @output_writer = Output::Writer.new(@options, @results)
      end

      def run
        abort?
        run_repeated
        @output_writer.write_summary
      end

      private

      def run_repeated
        (1..repeate=repeating_times).each do | round |
          Output::ConsoleWriter.console("round #{round}:\n")
          request_urls
          wait? if round < repeate
        end
      end

      def repeating_times
        repeating = @options[:repeate].to_i
        repeating = 1 if repeating < 1
        repeating
      end

      def request_urls
        urls = @options[:urls]
        raise PagePerformance::Error::NoUrlToTest if urls == nil
        urls.each do |url|
          request_url(url)
        end
      end

      def request_url(url)
        url = Utils::HttpHelper.new.formated_url(url, @options[:base_url], @options[:basic_auth][:user], @options[:basic_auth][:password])
        request_answer = `phantomjs --ignore-ssl-errors=#{@options[:ignore_ssl_errors]} #{@phantomjs_script} #{url}`.gsub(/\n/,'')
        add_to_results_hash(url, request_answer)
        write_output(url, request_answer)
      end

      def add_to_results_hash(url, request_answer)
        if @results.has_key?(url)
          @results[url] << request_answer
          return
        end
        @results[url] = [request_answer]
      end

      def write_output(url, request_answer)
        @output_writer.url = url
        @output_writer.request_answer = request_answer
        @output_writer.write_result
      end

      def abort?
        trap("SIGINT") do
          puts "\n*** bye bye and have a nice day ..."
          exit!
        end
      end

      def wait?
        waiting_time = @options[:wait]
        return unless waiting_time
        waiting_time = waiting_time.to_i
        Output::ConsoleWriter.console("... waiting for #{waiting_time} s\n")
        sleep(waiting_time)
      end
    end
  end
end