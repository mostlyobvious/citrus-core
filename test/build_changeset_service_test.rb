require 'test_helper'
require 'citrus/core/build_changeset_service'

module Citrus
  module Core
    class BuildChangesetServiceTest < MiniTest::Unit::TestCase

      def sample_changeset
        mock('changeset')
      end

      def test_should_be_initialized_with_runner
        runner = mock('runner')
        BuildChangesetServiceTest.new(runner)
      end

      def test_should_execute_build_on_run
        runner = mock('runner')
        runner.expects(:run)

        service = BuildChangesetService.new(runner)
        service.run(sample_changeset)
      end

      def test_should_return_build_after_run
        build  = mock('build')
        runner = mock('runner')
        runner.expects(:run).returns(build)

        service = BuildChangesetService.new(runner)
        assert_equal build, service.run(sample_changeset)
      end

    end
  end
end
