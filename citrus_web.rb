require 'sinatra'
require 'citrus/core'

post '/' do
  adapter   = Citrus::Core::GithubAdapter.new
  changeset = adapter.create_changeset_from_push_data(params[:payload])
  build     = Citrus::Core::Build.new(changeset)
  service   = Citrus::Core::ExecuteBuildService.new

  if service.start(build).result == 0
    puts "[#{build.uuid}] Sukces, milordzie!"
  else
    puts "[#{build.uuid}] Poracha, milordzie."
  end
end
