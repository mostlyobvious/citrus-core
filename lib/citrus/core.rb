module Citrus
  module Core
    class << self

      def build_root
        @build_root || root.join('builds')
      end

      def config_path
        Pathname.new('.citrus/config.rb')
      end

      def root
        Pathname.new(File.expand_path('../../', File.dirname(__FILE__)))
      end

    end
  end
end
