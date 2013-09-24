module Citrus
  module Core
    class TestOutput

      def initialize
        @output = ""
      end

      def write(data)
        @output << data
      end

      def read
        @output
      end

    end
  end
end
