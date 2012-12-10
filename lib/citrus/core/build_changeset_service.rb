require 'citrus/core/build'
require 'citrus/core/workspace'
require 'citrus/core/configuration'

module Citrus
  module Core
    class BuildChangesetService
      ROOT_PATH = '/tmp'

      def initialize(runner)
        @runner  = runner
      end

      def run(changeset)
        build = Build.new(changeset)
        workspace = Workspace.new(ROOT_PATH, build)
        workspace.prepare
        configuration = Configuration.new
        @runner.run(build, configuration, workspace)
        build
      end
    end
  end
end
