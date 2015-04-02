require 'Logger'

module PagePerformance
  module Utils
    class Logging
      attr_reader :level

      def initialize(level)
        @level = level
        setup
      end

      def log(message)
        @logger.warn(message)
      end

      private

      def setup
        @logger       = Logger.new(STDOUT)
        @logger.level = log_level
      end

      def log_level
        case @level
          when 'info'  then Logger::INFO
          when 'warn'  then Logger::WARN
          when 'debug' then Logger::DEBUG
          when 'fatal' then Logger::FATAL
        end
      end
    end
  end
end