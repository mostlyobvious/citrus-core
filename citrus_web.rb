require 'sinatra'
require 'citrus/core'

helpers do
  def build_succeeded(build)
    puts "[#{build.uuid}] Sukces, milordzie!"
  end
end

post '/' do
  adapter   = Citrus::Core::GithubAdapter.new
  changeset = adapter.create_changeset_from_push_data(params[:payload])
  build     = Citrus::Core::Build.new(changeset)
  service   = Citrus::Core::ExecuteBuildService.new
  service.add_subscriber(self)
  service.start(build)
end
