require 'pathname'

module Citrus
  module Core
    class Workspace

      def initialize(root_path, build)
        @uuid = build.uuid
        @root = Pathname.new(root_path)
      end

      def path
        @root.join(partition, @uuid).to_s
      end

      def prepare
        create_workspace
      end

      protected

      def partition
        Time.now.strftime('%Y/%m/%d')
      end

      def create_workspace
        FileUtils.mkdir_p(path)
      end

    end
  end
end
