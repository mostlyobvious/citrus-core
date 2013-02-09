require 'securerandom'

module Citrus
  module Core
    class Build
      attr_reader :uuid, :result

      def initialize(changeset)
        @changeset = changeset
        @uuid = SecureRandom.uuid
      end

      def succeed
        @result = :success
      end

      def fail
        @result = :failure
      end

      def abort
        @result = :aborted
      end
    end
  end
end
