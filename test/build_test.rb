require 'test_helper'
require 'citrus/core/build'

module Citrus
  module Core
    class BuildTest < MiniTest::Unit::TestCase

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
        changeset = mock('changeset')
        build = Build.new(changeset)

        assert_respond_to build, :result
      end

    end
  end
end
