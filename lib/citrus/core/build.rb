require 'stringio'
require 'securerandom'

module Citrus
  module Core
    class Build

      attr_reader :changeset, :uuid, :output

      def initialize(changeset, uuid = SecureRandom.uuid, output = TestOutput.new)
        @changeset = changeset
        @uuid      = uuid
        @output    = output
      end

    end
  end
end
