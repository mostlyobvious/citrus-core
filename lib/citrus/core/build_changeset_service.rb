require 'citrus/core/build'
require 'citrus/core/workspace'
require 'citrus/core/configuration'

module Citrus
  module Core
    class BuildChangesetService
      ROOT_PATH = '/tmp'

      def initialize(runner = Runner.new)
        @runner  = runner
      end

      def run(changeset)
        build = Build.new(changeset)
        workspace = Workspace.new(ROOT_PATH, build)
        workspace.prepare
        configuration = Configuration.new
        return @runner.run(build, configuration, workspace)
      end
    end
  end
end
