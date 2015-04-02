#
# This module includes the main method 'run' which is invoked
# by the run_page_perfomance script
#
module PagePerformance

  # main method to be invoked
  #
  # @param [String] args input from command line
  def self.run(args)
    @argv_parser  = PagePerformance::Utils::ArgvParser.new(args)
    @logger       = PagePerformance::Utils::Logging.new('warn')

    begin
      check_prerequisites
      parse_cl
      run_pageperformance
    rescue PagePerformance::Error::NoUrlToTest => e
      @logger.log(e.message)
    rescue PagePerformance::Error::RubyVersion => e
      @logger.log(e.message)
    rescue PagePerformance::Error::Phantomjs => e
      @logger.log(e.message)
    rescue Net::HTTPServerException => e
      @logger.log(e.message)
    end
  end

  # version
  #
  # @return [String]
  def self.version
    '0.5.1'
  end

  private

  # check various prerequisites like Phantomjs availability
  # and Ruby version
  #
  # @return
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
end