require 'digest/sha1'

module Citrus
  module Core
    class CachedCodeFetcher

      attr_reader :cache_root, :vcs_adapter, :digester

      def initialize(cache_root, vcs_adapter = GitAdapter.new, digester = Digest::SHA1)
        @cache_root  = cache_root
        @vcs_adapter = vcs_adapter
        @digester    = digester
      end

      def fetch(changeset, destination)
        url  = changeset.repository_url
        head = changeset.head
        cache_dir = File.join(cache_root, digester.hexdigest(url))
        FileUtils.mkpath(cache_dir)
        update_cache(url, cache_dir)
        vcs_adapter.clone_repository(cache_dir, destination)
        vcs_adapter.checkout(destination, head)
      end

      protected

      def update_cache(url, cache_dir)
        return vcs_adapter.clone_repository(url, cache_dir) if Dir.entries(cache_dir).size == 2
        vcs_adapter.fetch_remote(cache_dir)
        vcs_adapter.reset(cache_dir)
      end

    end
  end
end
