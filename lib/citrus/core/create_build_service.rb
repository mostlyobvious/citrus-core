require 'citrus/core'
require 'securerandom'

module Citrus
  module Core
    class CreateBuildService

      def create_from_changeset(changeset)
        Build.new(changeset, SecureRandom.uuid, StringIO.new)
      end

      def create_from_github_push(push_data, adapter = GithubAdapter.new)
        create_from_changeset(adapter.create_changeset_from_push_data(push_data))
      end
    end
  end
end
