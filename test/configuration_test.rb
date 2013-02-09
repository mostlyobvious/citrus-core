require 'test_helper'
require 'citrus/core/configuration'

module Citrus
  module Core
    class ConfigurationTest < MiniTest::Unit::TestCase

      def sample_configuration_path
        File.join(File.dirname(__FILE__), 'sample_app/.citrus/config.rb')
      end

      def test_should_load_configuration_from_file
        assert_kind_of Configuration, Configuration.load_from_file(sample_configuration_path)
      end

      def test_should_be_aliased_to_configuration
        assert_kind_of Citrus::Configuration, Configuration.new
      end

      def test_should_recognize_build_script
        config = Configuration.load_from_file(sample_configuration_path)
        assert_equal "ruby -I. sample_test.rb", config.build_script
      end

      def test_describe_should_return_configuration_instance
        config = Proc.new { |c| c.build('echo hello world') }
        assert_kind_of Configuration, Configuration.describe(&config)
      end

    end
  end
end
