require 'securerandom'

module Citrus
  module Core
    class Build

      attr_reader :changeset, :uuid

      def initialize(changeset, uuid = SecureRandom.uuid)
        @changeset = changeset
        @uuid      = uuid
      end

    end
  end
end
