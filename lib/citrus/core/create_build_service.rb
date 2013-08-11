require 'citrus/core'
require 'securerandom'

module Citrus
  module Core
    class CreateBuildService

      attr_reader :root_path, :uuid_provider

      def initialize(root_path = Citrus::Core.build_root, uuid_provider = SecureRandom)
        @root_path     = root_path
        @uuid_provider = uuid_provider
      end

      def create_from_changeset(changeset)
        uuid = uuid_provider.uuid
        path = root_path.join(partition, uuid)
        path.mkpath
        Build.new(changeset, uuid, File.new(path.join('build.log'), 'w'))
      end

      def create_from_github_push(push_data, adapter = GithubAdapter.new)
        create_from_changeset(adapter.create_changeset_from_push_data(push_data))
      end

      protected

      def partition
        Time.now.strftime('%Y/%m/%d')
      end

    end
  end
end
