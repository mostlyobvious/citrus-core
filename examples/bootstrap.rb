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

  def output_received(data)
    print data
  end
end

include Citrus::Core

payload = Pathname.new(File.dirname(__FILE__)).join('payload.json').read
changeset = GithubAdapter.new.create_changeset_from_push_data(payload)
build = Build.new(changeset)
workspace_builder = WorkspaceBuilder.new
configuration_loader = ConfigurationLoader.new
test_runner = TestRunner.new
subscriber = Notifier.new
test_runner.add_subscriber(subscriber)
build_service = ExecuteBuildService.new(workspace_builder, configuration_loader, test_runner)
build_service.add_subscriber(subscriber)
build_service.start(build)


