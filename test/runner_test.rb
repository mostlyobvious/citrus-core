require 'test_helper'
require 'citrus/core/runner'

module Citrus
  module Core
    class RunnerTest < MiniTest::Unit::TestCase

      def sample_runner
        Runner.new
      end

      def test_should_respond_to_run
        assert_respond_to sample_runner, :run
      end

      def test_should_return_build_after_run
        build = mock('build')
        configuration = mock('configuration')
        workspace = mock('workspace')

        assert_equal build, sample_runner.run(build, configuration, workspace)
      end

    end
  end
end
