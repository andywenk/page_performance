module PagePerformance
  def self.run(args)
    PagePerformance::Prerequisites.check_prerequisites
    
    cli_parser = PagePerformance::ArgvParser.new(args)
    cli_parser.parse
    
    testrunner = PagePerformance::Testrunner.new(cli_parser.options)
    testrunner.run
  end
end