require 'test_helper'
require 'citrus/core/commit'

module Citrus
  module Core
    class CommitTest < MiniTest::Unit::TestCase

      def sample_commit
        sha       = mock('sha')
        author    = mock('author')
        message   = mock('message')
        changes   = mock('changes')
        timestamp = mock('timestamp')
        Commit.new(sha, author, message, timestamp, changes)
      end

      def test_should_be_initialized_with_sha_author_message_timestamp_and_changes
        sha       = mock('sha')
        author    = mock('author')
        message   = mock('message')
        changes   = mock('changes')
        timestamp = mock('timestamp')
        Commit.new(sha, author, message, timestamp, changes)
      end

      def test_should_respond_to_url
        assert_respond_to sample_commit, :url
      end

      def test_should_respond_to_sha
        assert_respond_to sample_commit, :sha
      end

      def test_should_respond_to_author
        assert_respond_to sample_commit, :author
      end

      def test_should_respond_to_timestamp
        assert_respond_to sample_commit, :timestamp
      end

      def test_should_respond_to_message
        assert_respond_to sample_commit, :message
      end

      def test_should_respond_to_changes
        assert_respond_to sample_commit, :changes
      end

    end
  end
end
