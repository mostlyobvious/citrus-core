require 'citrus/core'
require 'pathname'

class Notifier
  def build_succeeded(build, output)
    puts "[#{build.uuid}] Build has succeeded."
  end

  def build_failed(build, output)
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

include Citrus::Core

github_adapter = GithubAdapter.new
changeset      = github_adapter.create_changeset_from_push_data(Pathname.new(File.dirname(__FILE__)).join('payload.json').read)

event_subscriber  = Notifier.new
workspace_builder = WorkspaceBuilder.new
config_loader     = ConfigurationLoader.new

test_runner = TestRunner.new
test_runner.add_subscriber(event_subscriber)

build_service = ExecuteBuildService.new(workspace_builder, config_loader, test_runner)
build_service.add_subscriber(event_subscriber)
build_service.start(Build.new(changeset))


