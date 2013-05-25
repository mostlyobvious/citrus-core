module Citrus
  module Core
    class CommitChanges

      attr_reader :added, :removed, :modified

      def initialize(added, removed, modified)
        @added    = added
        @removed  = removed
        @modified = modified
      end

    end
  end
end
