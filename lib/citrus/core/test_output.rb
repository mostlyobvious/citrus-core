module Citrus
  module Core
    class TestOutput

      def initialize
        @output = []
      end

      def write(data)
        @output << data
      end

      def output
        @output.join
      end

    end
  end
end
