require 'test_helper'
require 'citrus/core/changeset'
require 'citrus/core/commit'

module Citrus
  module Core
    class ChangesetTest < MiniTest::Unit::TestCase

      def sample_changeset
        commit     = mock('commit')
        repository = mock('repository')
        Changeset.new(repository, [commit])
      end

      def test_should_be_initialized_with_repository_and_commits
        commit     = mock('commit')
        repository = mock('repository')
        Changeset.new(repository, [commit])
      end

      def test_should_respond_to_commits
        assert_respond_to sample_changeset, :commits
      end

      def test_should_respond_to_repository
        assert_respond_to sample_changeset, :repository
      end

    end
  end
end
