require 'citrus/core'
require 'citrus/core/build'
require 'citrus/core/workspace'
require 'citrus/core/configuration'

module Citrus
  module Core
    class BuildChangesetService

      def initialize(runner = Runner.new)
        @runner  = runner
      end

      def run(changeset)
        build     = Build.new(changeset)
        workspace = Workspace.new(Core.build_root, build)

        workspace.prepare
        configuration = Configuration.load_from_file(workspace.path.join(Core.config_path))

        unless configuration.build_script
          build.abort
        else
          status = @runner.run(configuration, workspace)
          status ? build.succeed : build.fail
        end

        return build
      end

    end
  end
end
