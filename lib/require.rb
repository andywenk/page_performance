# external libraries are only loaded in the classes where needed

# project libraries

# add the current directory (lib) to the load path
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'page_performance'
require 'page_performance/base/run'
require 'page_performance/error/error'
require 'page_performance/utils/prerequisites'
require 'page_performance/utils/argv_parser'
require 'page_performance/utils/tag_scanner'
require 'page_performance/output/writer'
require 'page_performance/output/console_writer'
require 'page_performance/output/file_writer'
