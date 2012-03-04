require './lib/prerequisites'
require './lib/cli_parser'
require './lib/testrunner'

module PagePerformance
  def self.run(args)
    PagePerformance::Prerequisites.check_prerequisites
    
    cli_parser = PagePerformance::CliParser.new(args)
    cli_parser.parse
    
    testrunner = PagePerformance::Testrunner.new(cli_parser.options)
    testrunner.run
  end
end