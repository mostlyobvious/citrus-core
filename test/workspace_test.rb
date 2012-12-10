require 'test_helper'
require 'citrus/core/workspace'
require 'securerandom'

module Citrus
  module Core
    class WorkspaceTest < MiniTest::Unit::TestCase

      def sample_build
        build = mock('build')
        build.expects(:uuid).returns('uuid')
        build
      end

      def sample_root
        Pathname.new('/tmp/abc')
      end

      def test_should_be_initialized_with_build_and_root_path
        Workspace.new(sample_root, sample_build)
      end

      def test_should_have_path
        workspace = Workspace.new(sample_root, sample_build)
        assert_respond_to workspace, :path
      end

      def test_should_nest_path_under_root_path
        workspace = Workspace.new(sample_root, sample_build)
        assert_match %r{\A#{sample_root}}, workspace.path
      end

      def test_should_partition_path
        build = mock('build')
        uuid  = SecureRandom.uuid
        build.expects(:uuid).returns(uuid)
        workspace = Workspace.new(sample_root, build)

        assert_match %r{\d{4}/\d{2}/\d{2}/#{uuid}\Z}, workspace.path
      end

      def test_should_respond_to_prepare
        workspace = Workspace.new(sample_root, sample_build)
        assert_respond_to workspace, :prepare
      end

      def test_should_create_path_on_prepare
        workspace = Workspace.new(sample_root, sample_build)
        workspace.prepare

        assert File.directory?(workspace.path)
      end

    end
  end
end
