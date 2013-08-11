module Citrus
  module Core
    class TestResult

      attr_reader :exit_code

      def initialize(exit_code)
        @exit_code  = exit_code.to_i
      end

      def success?
        exit_code == 0
      end

      def failure?
        !success?
      end

    end
  end
end
