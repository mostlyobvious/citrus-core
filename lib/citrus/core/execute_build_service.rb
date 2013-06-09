require 'citrus/core'

module Citrus
  module Core
    class ExecuteBuildService
      include Publisher

      attr_reader :workspace_builder, :configuration_loader, :test_runner

      def initialize(workspace_builder = WorkspaceBuilder.new, configuration_loader = ConfigurationLoader.new, test_runner = TestRunner.new)
        @workspace_builder    = workspace_builder
        @configuration_loader = configuration_loader
        @test_runner          = test_runner
      end

      def start(build)
        path = workspace_builder.create_workspace(build)
        configuration = configuration_loader.load_from_path(path)
        publish(:build_started, build)
        result = test_runner.start(configuration, path)
        publish(:build_succeeded, build, result.output) if result.success?
        publish(:build_failed, build, result.output)    if result.failure?
      rescue ConfigurationError => error
        publish(:build_aborted, build, error)
        raise error
      end

    end
  end
end
