require 'digest/sha1'

module Citrus
  module Core
    class CachedCodeFetcher

      attr_reader :cache_root, :vcs_adapter

      def initialize(cache_root, vcs_adapter)
        @cache_root  = cache_root
        @vcs_adapter = vcs_adapter
      end

      def fetch(changeset, destination)
        url  = changeset.repository_url
        head = changeset.head
        cache_dir = cache_root.join(Digest::SHA1.hexdigest(url))
        cache_dir.mkpath
        update_cache(url, cache_dir)
        vcs_adapter.clone_repository(cache_dir, destination)
        vcs_adapter.checkout(destination, head)
      end

      protected

      def update_cache(url, cache_dir)
        return vcs_adapter.clone_repository(url, cache_dir) unless cache_dir.join('.git').exist?
        vcs_adapter.fetch_remote(cache_dir)
        vcs_adapter.reset(cache_dir)
      end

    end
  end
end
