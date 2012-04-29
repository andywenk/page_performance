module PagePerformance
  def self.run(args)
    PagePerformance::Utils::Prerequisites.check_prerequisites
    
    cli_parser = PagePerformance::Utils::ArgvParser.new(args)
    cli_parser.parse
    
    testrunner = PagePerformance::Base::Run.new(cli_parser.options)
    testrunner.run

    rescue PagePerformance::Error::NoUrlToTest => e
      puts e.message
      exit
  end

  def self.version
    '0.2.1'
  end
end