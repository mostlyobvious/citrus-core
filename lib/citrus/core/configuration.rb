module Citrus
  module Core
    class Configuration

      attr_accessor :build_script

      def self.describe
        config = self.new
        yield config if block_given?
        config
      end

    end
  end

  Configuration = Core::Configuration
end
