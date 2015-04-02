$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'page_performance'

describe PagePerformance do
  it "should return a version number" do
    PagePerformance.version.should_not be_empty
  end
end