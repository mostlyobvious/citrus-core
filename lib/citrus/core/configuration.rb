module Citrus
  module Core
    class Configuration

      attr_accessor :build_script

      def build(script)
        @build_script = script
      end

      def self.describe(&block)
        config = self.new
        block.call(config)
        config
      end

      def self.load_from_file(path)
        eval File.read(path)
      end

    end
  end

  Configuration = Core::Configuration
end
