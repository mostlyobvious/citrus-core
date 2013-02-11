require 'pathname'

module Citrus
  module Core
    class Workspace

      def initialize(root_path, build)
        @uuid = build.uuid
        @root = Pathname.new(root_path)
      end

      def path
        @root.join(partition, @uuid)
      end

      def prepare
        create_workspace
      end

      protected

      def partition
        Time.now.strftime('%Y/%m/%d')
      end

      def create_workspace
        FileUtils.mkdir_p(path.to_s)
      end

    end
  end
end
