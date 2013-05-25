module Citrus
  module Core
    class WorkspaceBuilder

      attr_reader :root_path, :code_fetcher

      def initialize(root_path, code_fetcher)
        @root_path    = root_path
        @code_fetcher = code_fetcher
      end

      def create_workspace(build)
        path = root_path.join(partition, build.uuid)
        path.mkpath
        code_fetcher.fetch(build.changeset, path)
        path
      end

      protected

      def partition
        Time.now.strftime('%Y/%m/%d')
      end

    end
  end
end
