require 'citrus/core'
require 'pathname'
require './examples/buftok'

class EventNotifier
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
end

class OutputNotifier
  def initialize
    @buffer = Hash.new { |hash, key| hash[key] = BufferedTokenizer.new }
  end

  def build_output_received(build, data)
    @buffer[build].extract(data).each do |line|
      puts "[#{build.uuid}] #{line}"
    end
  end
end

include Citrus::Core

github_adapter    = GithubAdapter.new
changeset         = github_adapter.create_changeset_from_push_data(Pathname.new(File.dirname(__FILE__)).join('payload.json').read)
event_subscriber  = EventNotifier.new
output_subscriber = OutputNotifier.new
workspace_builder = WorkspaceBuilder.new
config_loader     = ConfigurationLoader.new
test_runner       = TestRunner.new
build_service     = ExecuteBuildUsecase.new(workspace_builder, config_loader, test_runner)

test_runner.add_subscriber(output_subscriber)
build_service.add_subscriber(event_subscriber)

build_service.start(Build.new(changeset))


