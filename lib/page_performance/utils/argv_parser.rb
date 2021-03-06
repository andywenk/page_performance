require 'optparse'

module PagePerformance
  module Utils
    # frontend for the arguments parsing provided at the command line
    # here the global @options array is created
    class ArgvParser
      attr_accessor :options, :version

      def initialize(args)
        @args = args
        @options = {}
        @version = PagePerformance.version
      end

      def parse
        @options[:ignore_ssl_errors] = 'no'

        option_parser = OptionParser.new do |opts|
          opts.banner = "PagePerformance v. #{@version}\n\nThis program is intended to test the performance of a website. It uses phantomjs which is a headless,\nwebkit based cli browser. "
          opts.set_program_name "Pageperformance v. #{@version}"
          opts.separator ""
          opts.separator "usage: run_page_performance [options]"
          opts.separator ""

          @options[:basic_auth] = {}

          opts.on("-u URLS", "--urls 'URLS'", "the URLS to test") do |urls|
            @options[:urls] = urls.gsub(/\s/,'').split(',')
          end

          opts.on("-f FILE", "--file FILE", "the URLS to test from a file") do |file|
            @options[:urls] = urls_from_file(file)
          end

          opts.on("-B", "--base-url URL", "Use this URL as base") do |base_url|
            @options[:base_url] = base_url
          end

          opts.on("-a", "--bau USER", "Basic-Authentication username") do |user|
            @options[:basic_auth_user] = user
          end

          opts.on("-p", "--bap PASSWORD", "Basic-Authentication password") do |password|
            @options[:basic_auth_password] = password
          end

          opts.on("-w", "--wait TIME", "the time to wait between the requests after the block of URLs") do |time|
            @options[:wait] = time
          end

          opts.on("-r", "--repeate INTEGER", "amount of repetition") do |amount|
            @options[:repeate] = amount.to_i
          end

          opts.on("-o", "--output STRING", "write results to this output file") do |output|
            @options[:output] = output_location(output)
          end

          opts.on("-g", "--gps-api-key STRING", "include Google PageSpeed results with this api key") do |key|
            @options[:google_api_key] = key
          end

          opts.on("-s", "--script", "count the <script> tags") do
            @options[:script] = true
            @options[:scan_tags] = true
          end

          opts.on("-i", "--iframe", "count the <iframe> tags") do
            @options[:iframe] = true
            @options[:scan_tags] = true
          end

          opts.on("-I","--ignore-ssl-errors", "advice Phantomjs to ignore SSL errors") do
            @options[:ignore_ssl_errors] = 'yes'
          end

          opts.on("-q", "--quiet", "no output durng program execution") do
            @options[:quiet] = true
          end

          opts.on_tail("-h", "--help", "show this message") do
            puts opts
            exit
          end

          opts.on_tail("-v", "--version", "show version") do
            puts @version
            exit
          end
        end

        option_parser.parse!(@args)
        exit_if_no_outputfile_given?

        rescue OptionParser::MissingArgument => error
          puts "Recheck your arguments please -> #{error}"
          exit

        rescue OptionParser::InvalidOption => error
          puts "There is a problem with your options -> #{error}"
          exit

        rescue PagePerformance::Error::NoUrlToTest => error
          puts error.message
          exit
      end

      def urls_from_file(location)
        urls = IO.readlines(location).map do |url|
          url = url.strip!
          next if url.match(/^#/) || url.empty?
          url.gsub(/\s|\n/,'')
        end
        urls = urls.compact
        raise PagePerformance::Error::NoUrlToTest if urls.empty?
        urls
      end

      def exit_if_no_outputfile_given?
        unless @options[:output]
          print "No outputfile given! Continue anyway? [y|n] "
          case gets.chomp
          when 'n'
            puts "*** bye bye ... and thanks for all the fish ;-)"
            exit
          when /[^y]/
            exit_if_no_outputfile_given?
            return true
          end
        end
        false
      end

      def output_location(output)
        case output
        when /^\//
          output
        when /^\.\//
          output
        else
          File.expand_path("../../../../#{output}", __FILE__)
        end
      end
    end
  end
end