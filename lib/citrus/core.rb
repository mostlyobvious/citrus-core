require 'pathname'

module Citrus
  module Core
    class << self

      def build_root
        @build_root || root.join('builds')
      end

      def cache_root
        @cache_root || root.join('cache')
      end

      def output_root
        @output_root || root.join('output')
      end

      def root
        Pathname.new(File.expand_path('../../', File.dirname(__FILE__)))
      end

    end
  end
end

require 'citrus/core/publisher'
require 'citrus/core/build'
require 'citrus/core/exit_code'
require 'citrus/core/workspace_builder'
require 'citrus/core/cached_code_fetcher'
require 'citrus/core/changeset'
require 'citrus/core/test_output'
require 'citrus/core/file_output'
require 'citrus/core/test_runner'
require 'citrus/core/github_adapter'
require 'citrus/core/commit'
require 'citrus/core/commit_changes'
require 'citrus/core/configuration'
require 'citrus/core/configuration_loader'
require 'citrus/core/configuration_validator'
require 'citrus/core/git_adapter'
require 'citrus/core/queued_builder'
require 'citrus/core/execute_build_usecase'
