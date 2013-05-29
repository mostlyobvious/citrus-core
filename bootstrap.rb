require 'citrus/core'
require 'pathname'

include Citrus::Core

payload   = Pathname.new(File.dirname(__FILE__)).join('example/payload.json').read
changeset = GithubAdapter.new.create_changeset_from_push_data(payload)
build     = Build.new(changeset)

code_fetcher      = CachedCodeFetcher.new(Citrus::Core.cache_root, GitAdapter.new)
workspace_builder = WorkspaceBuilder.new(Citrus::Core.build_root, code_fetcher)
test_runner       = TestRunner.new
config_loader     = ConfigurationLoader.new(ConfigurationValidator.new)
build_service     = ExecuteBuildService.new(workspace_builder, config_loader, test_runner)

result = build_service.start(build)
puts 'sukces milordzie' if result.result == 0


