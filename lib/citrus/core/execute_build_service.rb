require 'citrus/core'

module Citrus
  module Core
    class ExecuteBuildService

      attr_reader :workspace_builder, :configuration_loader, :test_runner

      def initialize(workspace_builder = WorkspaceBuilder.new, configuration_loader = ConfigurationLoader.new, test_runner = TestRunner.new)
        @workspace_builder    = workspace_builder
        @configuration_loader = configuration_loader
        @test_runner          = test_runner
      end

      def start(build)
        path = workspace_builder.create_workspace(build)
        configuration = configuration_loader.load_from_path(path)
        return test_runner.start(configuration, path)
      end

    end
  end
end
