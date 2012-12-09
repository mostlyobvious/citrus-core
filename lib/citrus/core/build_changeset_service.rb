require 'citrus/core/build'

module Citrus
  module Core
    class BuildChangesetService

      def initialize(runner)
        @runner = runner
      end

      def run(changeset)
        build = Build.new(changeset)
        @runner.run(build)
        build
      end
    end
  end
end
