require 'test_helper'
require 'citrus/core/build'

module Citrus
  module Core
    class BuildTest < MiniTest::Unit::TestCase

      def sample_changeset
        changeset = mock('changeset')
      end

      def test_should_be_initialized_with_changeset
        changeset = mock('changeset')
        Build.new(changeset)
      end

      def test_should_have_uuid
        changeset = mock('changeset')
        build = Build.new(changeset)

        assert_match /[a-z0-9\-]{36}/, build.uuid
      end

      def test_should_have_result
        build = Build.new(sample_changeset)
        assert_respond_to build, :result
      end

      def test_should_respond_to_succeed
        build = Build.new(sample_changeset)
        assert_respond_to build, :succeed
      end

      def test_succeed_should_make_build_successful
        build = Build.new(sample_changeset)
        build.succeed
        assert_equal :success, build.result
      end

      def test_should_respond_to_fail
        build = Build.new(sample_changeset)
        assert_respond_to build, :fail
      end

      def test_fail_should_make_build_failed
        build = Build.new(sample_changeset)
        build.fail
        assert_equal :failure, build.result
      end

      def test_should_respond_to_abort
        build = Build.new(sample_changeset)
        assert_respond_to build, :abort
      end

      def test_fail_should_make_build_aborted
        build = Build.new(sample_changeset)
        build.abort
        assert_equal :aborted, build.result
      end

    end
  end
end
