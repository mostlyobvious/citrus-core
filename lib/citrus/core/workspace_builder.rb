module Citrus
  module Core
    class WorkspaceBuilder

      attr_reader :build_root, :code_fetcher

      def initialize(build_root, code_fetcher)
        @build_root   = build_root
        @code_fetcher = code_fetcher
      end

      def create_workspace(build)
        path = File.join(build_root, partition, build.uuid)
        FileUtils.mkpath(path)
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
