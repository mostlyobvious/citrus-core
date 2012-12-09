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
        changeset = mock('changeset')
        runner = mock('runner')
        runner.expects(:run)

        service = BuildChangesetService.new(runner)
        service.run(changeset)
      end

      def test_should_return_build_after_run
        changeset = mock('changeset')
        runner = mock('runner')
        runner.expects(:run)

        service = BuildChangesetService.new(runner)
        assert_kind_of Build, service.run(changeset)
      end

      def test_should_return_successful_build_when_expected
        runner = mock('runner')
        runner.expects(:run)

        service = BuildChangesetService.new(runner)
        build = service.run(sample_changeset)
        assert_equal :success, build.result
      end

    end
  end
end
