require 'test_helper'
require 'citrus/core/repository'

module Citrus
  module Core
    class RepositoryTest < MiniTest::Unit::TestCase

      def test_should_be_initialized_with_url
        Repository.new('http://github.com/defunkt/github')
      end

      def test_should_respond_to_url
        repository = Repository.new('http://github.com/defunkt/github')
        assert_respond_to repository, :url
      end

    end
  end
end
