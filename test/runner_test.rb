require 'test_helper'
require 'citrus/core/runner'

module Citrus
  module Core
    class RunnerTest < MiniTest::Unit::TestCase

      def sample_runner
        Runner.new
      end

      def sample_success_configuration
        Configuration.load_from_file(File.join(success_app_path, '.citrus/config.rb'))
      end

      def sample_failure_configuration
        Configuration.load_from_file(File.join(failure_app_path, '.citrus/config.rb'))
      end

      def success_app_path
        File.join(File.dirname(__FILE__), 'success_app')
      end

      def failure_app_path
        File.join(File.dirname(__FILE__), 'failure_app')
      end

      def test_should_respond_to_run
        assert_respond_to sample_runner, :run
      end

      def test_should_return_build_after_run
        build = Build.new(mock('changeset'))
        workspace = mock('workspace', :path => success_app_path)

        assert_equal build, sample_runner.run(build, sample_success_configuration, workspace)
      end

      def test_successful_run
        build = mock('build')
        build.expects('succeed')
        workspace = mock('workspace')
        workspace.expects('path').returns(success_app_path)

        sample_runner.run(build, sample_success_configuration, workspace)
      end

      def test_failed_run
        build = mock('build')
        build.expects('fail')
        workspace = mock('workspace')
        workspace.expects('path').returns(failure_app_path)

        sample_runner.run(build, sample_failure_configuration, workspace)
      end

      def test_aborted_run_due_to_empty_build_script
        build = mock('build')
        build.expects('abort')

        sample_runner.run(build, Configuration.new, mock('workspace'))
      end

    end
  end
end
