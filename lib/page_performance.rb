# This module includes the main method 'run' which is invoked 
# by the run_page_perfomance script
module PagePerformance
  # main method to be invoked
  # @param [String] args input from command line
  def self.run(args)
    @argv_parser = PagePerformance::Utils::ArgvParser.new(args)

    check_prerequisites
    parse_cl
    run_pageperformance
    rescue_errors
  end

  # @return [String]
  def self.version
    '0.3.0'
  end

  private

  # check various prerequisites like Phantomjs availability and Ruby version
  def self.check_prerequisites
    PagePerformance::Utils::Prerequisites.check_prerequisites
  end

  # parse the command line
  def self.parse_cl
    @argv_parser.parse
  end

  # start running the page_performance tests
  def self.run_pageperformance
    page_performance = PagePerformance::Base::Run.new(@argv_parser.options)
    page_performance.run
  end

  # rescue errors, write them to STDOUT and exit if errors occure
  def self.rescue_errors
    rescue PagePerformance::Error::NoUrlToTest => exception
      puts exception.message
      exit
  end
end