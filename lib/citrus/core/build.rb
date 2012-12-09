require 'securerandom'

module Citrus
  module Core
    class Build
      attr_reader :uuid, :result

      def initialize(changeset)
        @changeset = changeset
        @uuid = SecureRandom.uuid
      end
    end
  end
end
