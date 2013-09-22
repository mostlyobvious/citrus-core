module Citrus
  module Core
    class TestOutput
      include Publisher

      def initialize
        @output = []
      end

      def write(data)
        @output << data
        publish(:test_output_received, data)
      end

      def output
        @output.join
      end

    end
  end
end
