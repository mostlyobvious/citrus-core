require 'json'
require 'time'

module Citrus
  module Core
    class GithubAdapter

      def create_changeset_from_push_data(push_data)
        data    = JSON.parse(push_data)
        commits = data['commits'].map do |commit|
          changes = CommitChanges.new(commit['added'], commit['removed'], commit['modified'])
          Commit.new(commit['id'], commit['author']['name'], commit['message'],
                     Time.parse(commit['timestamp']), changes, commit['url'])
        end
        repository = Repository.new(data['repository']['url'])
        return Changeset.new(repository, commits)
      end

    end
  end
end
