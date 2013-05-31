require 'citrus/core'
require 'pathname'

payload       = Pathname.new(File.dirname(__FILE__)).join('example/payload.json').read
changeset     = Citrus::Core::GithubAdapter.new.create_changeset_from_push_data(payload)
build         = Citrus::Core::Build.new(changeset)
build_service = Citrus::Core::ExecuteBuildService.new

puts 'Sukces, milordzie.' if build_service.start(build).result == 0


