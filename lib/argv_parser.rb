module PagePerformance
  class ArgvParser
    attr_accessor :options, :version

    def initialize(args)
      @args = args
      @options = {}
      @version = '0.0.2'
    end

    def parse
      option_parser = OptionParser.new do |opts|
        opts.banner = "Pageperformance v. #{@version}\n\nThis program is intended to test the performance of a website. It uses phantomjs which is a headless,\nwebkit based cli browser. "
        opts.set_program_name "Pageperformance v. #{@version}"
        opts.separator ""
        opts.separator "usage: page_performance_test.rb [options]"
        opts.separator ""

        opts.on("-u URLS", "--urls 'URLS'", "the URLS to test") do |urls|
          @options[:urls] = urls.gsub(/\s/,'').split(',')
        end

        opts.on("-f FILE", "--file FILE", "the URLS to test from a file") do |file|
          @options[:urls] = urls_from_file(file)
        end

        opts.on("-w", "--wait TIME", "the time to wait between the requests after the block of URLs") do |time|
          @options[:wait] = time
        end

        opts.on("-r", "--repeate INTEGER", "amount of repetition") do |amount|
          @options[:repeate] = amount.to_i
        end

        opts.on("-o", "--output STRING", "write results to this output file") do |output|
          @options[:output] = output
        end

        opts.on("-s", "--script", "count the <script> tags") do
          @options[:script] = true
          @options[:scan_tags] = true
        end

        opts.on("-i", "--iframe", "count the <iframe> tags") do
          @options[:iframe] = true
          @options[:scan_tags] = true
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

      rescue OptionParser::MissingArgument => error
        puts "Recheck your arguments please -> #{error}"
        exit

      rescue OptionParser::InvalidOption => error
        puts "There is a problem with your options -> #{error}"
        exit
    end

    def urls_from_file(location)
      urls = IO.readlines(location).map { |url| url.gsub(/\s|\n/,'')}
    end
  end
end