$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'page_performance/utils/argv_parser'
require 'page_performance/error/error'

describe PagePerformance::Utils::ArgvParser do
  before(:each) do
    @avp = PagePerformance::Utils::ArgvParser.new('')
  end

  it "should not exit when options[:output] is given" do
    @avp.options = {:output => 'output_file'}
    @avp.exit_if_no_outputfile_given?.should be false
  end

  it "should print a message when options[:output] is not given" do
    @avp.options = {:output => nil}
    @avp.exit_if_no_outputfile_given?.should be true
  end

  it "should return the correct output location" do
    @avp.output_location('output').should == File.expand_path("../../output", __FILE__)
    @avp.output_location('./output').should == './output'
    @avp.output_location('/tmp/output').should == '/tmp/output'
  end

  it "should raise an error if no urls are provided for urls_from_file" do
    lambda { @avp.urls_from_file(File.expand_path("../urls_empty", __FILE__)) }.should 
      raise_error(PagePerformance::Error::NoUrlToTest) 
  end

  it "should return a list of URL's for urls_from_file" do
    pending
    @avp.urls_from_file(File.expand_path("../urls_not_empty", __FILE__)).should == ''
  end
end