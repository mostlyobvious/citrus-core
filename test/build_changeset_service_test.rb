require 'test_helper'
require 'citrus/core/build_changeset_service'

module Citrus
  module Core
    class BuildChangesetServiceTest < MiniTest::Unit::TestCase
      include FakeFilesystemHelper

      def sample_changeset
        mock('changeset')
      end

      def sample_runner
        stub('runner', :run => true)
      end

      def valid_configuration
        Configuration.describe { |c| c.build "whoami" }
      end

      def invalid_confuguration
        Configuration.new
      end

      def expect_configuration_load(configuration = valid_configuration)
        Configuration.expects(:load_from_file).returns(configuration)
      end

      def test_should_be_initialized_with_runner
        BuildChangesetServiceTest.new(mock('runner'))
      end

      def test_should_read_configuration_from_workspace
        expect_configuration_load
        service = BuildChangesetService.new(sample_runner)
        service.run(sample_changeset)
      end

      def test_should_execute_build_on_run
        expect_configuration_load
        runner = mock('runner')
        runner.expects(:run)

        service = BuildChangesetService.new(runner)
        service.run(sample_changeset)
      end

      def test_should_return_build_after_run
        expect_configuration_load
        service = BuildChangesetService.new(sample_runner)
        assert_kind_of Build, service.run(sample_changeset)
      end

      def test_should_resolve_build_as_success_on_successful_run
        expect_configuration_load
        runner = mock('runner')
        runner.expects(:run).returns(true)
        Build.any_instance.expects(:succeed)

        service = BuildChangesetService.new(runner)
        service.run(sample_changeset)
      end

      def test_should_resolve_build_as_failure_on_failed_run
        expect_configuration_load
        runner = mock('runner')
        runner.expects(:run).returns(false)
        Build.any_instance.expects(:fail)

        service = BuildChangesetService.new(runner)
        service.run(sample_changeset)
      end

      def test_should_resolve_build_as_aborted_on_invalid_configuration
        expect_configuration_load(invalid_confuguration)
        runner = mock('runner')
        Build.any_instance.expects(:abort)

        service = BuildChangesetService.new(runner)
        service.run(sample_changeset)
      end

    end
  end
end
