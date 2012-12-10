require 'test_helper'
require 'citrus/core/runner'

module Citrus
  module Core
    class RunnerTest < MiniTest::Unit::TestCase

      def sample_runner
        Runner.new
      end

      def test_should_respond_to_run
        assert_respond_to sample_runner, :run
      end

    end
  end
end
