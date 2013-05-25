module Citrus
  module Core
    class << self

      def build_root
        @build_root || root.join('builds')
      end

      def config_path
        Pathname.new('.citrus/config.rb')
      end

      def root
        Pathname.new(File.expand_path('../../', File.dirname(__FILE__)))
      end

    end
  end
end

require 'citrus/core/build'
require 'citrus/core/workspace_builder'
require 'citrus/core/cached_code_fetcher'
require 'citrus/core/changeset'
require 'citrus/core/test_result'
require 'citrus/core/test_runner'
require 'citrus/core/commit'
require 'citrus/core/commit_changes'
require 'citrus/core/configuration'
require 'citrus/core/configuration_loader'
require 'citrus/core/configuration_validator'
require 'citrus/core/git_adapter'
require 'citrus/core/execute_build_service'
