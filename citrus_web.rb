require 'sinatra'
require 'citrus/core'


class ConsoleNotifier

  attr_reader :io

  def initialize(io = STDOUT)
    @io = io
  end

  def build_succeeded(build)
    io.puts "[#{build.uuid}] Build has succeeded."
  end

  def build_failed(build)
    io.puts "[#{build.uuid}] Build has failed."
  end

  def build_aborted(build)
    io.puts "[#{build.uuid}] Build has been aborted."
  end

  def build_started(build)
    io.puts "[#{build.uuid}] Build has started."
  end

end

class QueuedBuilder

  attr_reader :queue, :service

  def initialize(queue, subscriber)
    @queue   = queue
    @service = Citrus::Core::ExecuteBuildService.new
    @service.add_subscriber(subscriber)
  end

  def run
    Thread.new do
      loop do
        build = queue.pop
        service.start(build)
      end
    end
  end

end


queue   = Queue.new
builder = QueuedBuilder.new(queue, ConsoleNotifier.new)
builder.run

post '/github_push' do
  adapter   = Citrus::Core::GithubAdapter.new
  changeset = adapter.create_changeset_from_push_data(params[:payload])
  build     = Citrus::Core::Build.new(changeset)
  queue << build
  'ok'
end

get '/queue' do
  "queue length is #{queue.size}"
end

get '/' do
  'welcome to citrus-web'
end
