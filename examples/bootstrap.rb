require 'citrus/core'
require 'pathname'
require 'tmpdir'

class EventSubscriber
  def build_succeeded(build, result)
    puts "[#{build.uuid}] Build has succeeded."
  end

  def build_failed(build, result)
    puts "[#{build.uuid}] Build has failed."
  end

  def build_aborted(build, error)
    puts "[#{build.uuid}] Build has been aborted."
  end

  def build_started(build)
    puts "[#{build.uuid}] Build has started."
  end

  def build_output_received(build, data)
    print data
  end
end

root = Dir.mktmpdir('citrus')
cache_root = File.join(root, 'cache')
build_root = File.join(root, 'builds')

github_adapter    = Citrus::Core::GithubAdapter.new
changeset         = github_adapter.create_changeset_from_push_data(Pathname.new(File.dirname(__FILE__)).join('payload.json').read)
event_subscriber  = EventSubscriber.new
code_fetcher      = Citrus::Core::CachedCodeFetcher.new(cache_root)
workspace_builder = Citrus::Core::WorkspaceBuilder.new(build_root, code_fetcher)
config_loader     = Citrus::Core::ConfigurationLoader.new
test_runner       = Citrus::Core::TestRunner.new
build_service     = Citrus::Core::ExecuteBuild.new(workspace_builder, config_loader, test_runner)

[test_runner, build_service].each { |publisher| publisher.add_subscriber(event_subscriber) }
build_service.(Citrus::Core::Build.new(changeset))


