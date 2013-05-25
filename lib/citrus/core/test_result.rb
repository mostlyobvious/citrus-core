module Citrus
  module Core
    class TestResult

      attr_reader :process_handle

      def initialize(process_handle)
        @process_handle = process_handle
      end

      def result
        process_handle.wait
        process_handle.exit_code
      end

    end
  end
end
