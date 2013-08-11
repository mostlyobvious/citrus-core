module Citrus
  module Core
    class Build

      attr_reader :changeset, :uuid, :output

      def initialize(changeset, uuid, output)
        @changeset = changeset
        @uuid      = uuid
        @output    = output
      end

    end
  end
end
