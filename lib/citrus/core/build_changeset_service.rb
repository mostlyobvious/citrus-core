require 'citrus/core/build'
require 'citrus/core/workspace'
require 'citrus/core/configuration'

module Citrus
  module Core
    class BuildChangesetService
      ROOT_PATH   = '/tmp'
      CONFIG_PATH = '.citrus/config.rb'

      def initialize(runner = Runner.new)
        @runner  = runner
      end

      def run(changeset)
        build = Build.new(changeset)
        workspace = Workspace.new(ROOT_PATH, build)
        workspace.prepare
        configuration = Configuration.load_from_file(File.join(workspace.path, CONFIG_PATH))

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
