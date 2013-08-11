require 'securerandom'
require 'stringio'

module Citrus
  module Core
    class Build

      attr_reader   :changeset, :uuid
      attr_accessor :output

      def initialize(changeset, uuid = SecureRandom.uuid)
        @changeset = changeset
        @uuid      = uuid
        @output    = StringIO.new
      end

    end
  end
end
