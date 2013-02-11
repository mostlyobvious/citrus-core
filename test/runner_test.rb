require 'test_helper'
require 'citrus/core/runner'

module Citrus
  module Core
    class RunnerTest < MiniTest::Unit::TestCase

      def sample_runner
        Runner.new
      end

      def test_path
        Citrus::Core.root.join('test/support')
      end

      def sample_success_configuration
        Configuration.describe { |c| c.build "./status 0" }
      end

      def sample_failure_configuration
        Configuration.describe { |c| c.build "./status 1" }
      end

      def test_should_respond_to_run
        assert_respond_to sample_runner, :run
      end

      def test_successful_run
        workspace = mock('workspace')
        workspace.expects('path').returns(test_path)

        assert sample_runner.run(sample_success_configuration, workspace)
      end

      def test_failed_run
        workspace = mock('workspace')
        workspace.expects('path').returns(test_path)

        refute sample_runner.run(sample_failure_configuration, workspace)
      end

    end
  end
end
