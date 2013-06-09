require 'stringio'

module Citrus
  module Core
    class TestResult

      attr_reader :value, :output

      def initialize(value, output = StringIO.new)
        @value  = value.to_i
        @output = output
      end

      def success?
        value == 0
      end

      def failure?
        !success?
      end

    end
  end
end
