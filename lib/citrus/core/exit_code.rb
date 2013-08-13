module Citrus
  module Core
    class ExitCode

      attr_reader :value

      def initialize(value)
        @value = value.to_i
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
