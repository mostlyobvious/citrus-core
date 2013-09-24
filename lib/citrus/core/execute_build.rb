module Citrus
  module Core
    class ExecuteBuild
      include Publisher

      attr_reader :workspace_builder, :configuration_loader, :test_runner

      def initialize(workspace_builder, configuration_loader = ConfigurationLoader.new, test_runner = TestRunner.new)
        @workspace_builder    = workspace_builder
        @configuration_loader = configuration_loader
        @test_runner          = test_runner
      end

      def start(build)
        workspace_path = workspace_builder.create_workspace(build)
        configuration  = configuration_loader.load_from_path(workspace_path)
        notify_build_start(build)
        result = test_runner.start(build, configuration, workspace_path)
        notify_build_result(build, result)
      rescue ConfigurationError => error
        notify_build_abort(build, error)
        raise
      end

      protected

      def notify_build_start(build)
        publish(:build_started, build)
      end

      def notify_build_result(build, result)
        publish(:build_succeeded, build, result) if result.success?
        publish(:build_failed,    build, result) if result.failure?
      end

      def notify_build_abort(build, error)
        publish(:build_aborted, build, error)
      end

    end
  end
end
