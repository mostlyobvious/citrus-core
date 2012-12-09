require 'citrus/core/commit'
require 'citrus/core/repository'
require 'multi_json'

module Citrus
  module Core
    class Changeset

      attr_reader :commits, :repository

      def self.from_github_payload(payload)
        data = MultiJson.load(payload)

        commits = data['commits'].collect do |commit|
          Commit.new(
            commit['id'],
            OpenStruct.new(commit['author']),
            commit['message'],
            DateTime.parse(commit['timestamp']),
            OpenStruct.new(
              'added'    => commit['added'],
              'removed'  => commit['removed'],
              'modified' => commit['modified']
            ),
            commit['url']
          )
        end
        repository = Repository.new(data['repository']['url'])

        self.new(repository, commits)
      end

      def initialize(repository, commits)
        @repository = repository
        @commits = commits
      end

    end
  end
end
