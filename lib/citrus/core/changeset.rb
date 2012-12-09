require 'citrus/core/commit'
require 'citrus/core/repository'

module Citrus
  module Core
    class Changeset

      attr_reader :commits, :repository

      def initialize(repository, commits)
        @repository = repository
        @commits = commits
      end

    end
  end
end
