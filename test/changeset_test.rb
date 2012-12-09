require 'test_helper'
require 'citrus/core/changeset'
require 'citrus/core/commit'

module Citrus
  module Core
    class ChangesetTest < MiniTest::Unit::TestCase

      def sample_github_payload
        File.read(File.join(File.dirname(__FILE__), 'support/sample_payload.json'))
      end

      def test_should_be_initialized_with_repository_and_commits
        commit     = mock('commit')
        repository = mock('repository')
        Changeset.new(repository, [commit])
      end

      def test_should_respond_to_commits
        commit     = mock('commit')
        repository = mock('repository')
        changeset = Changeset.new(repository, [commit])
        assert_respond_to changeset, :commits
      end

      def test_should_create_instance_from_github_payload
        assert_respond_to Changeset, :from_github_payload
      end

      def test_should_have_commits_from_github_payload
        changeset = Changeset.from_github_payload(sample_github_payload)
        assert_kind_of Commit, changeset.commits.first
      end

      def test_should_have_repository_from_github_payload
        changeset = Changeset.from_github_payload(sample_github_payload)
        assert_kind_of Repository, changeset.repository
      end

    end
  end
end
