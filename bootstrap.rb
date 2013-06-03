# encoding: utf-8

require 'citrus/core'
require 'pathname'

class Notifier
  def build_succeeded(build); puts 'Sukces, milordzie.'; end
  def build_failed(build);    puts 'Blamaż, milordzie.'; end
  def build_aborted(build);   puts 'Bo to zła konfiguracja była, milordzie.'; end
  def build_started(build);   puts 'Testuję, milordzie.'; end
end

payload       = Pathname.new(File.dirname(__FILE__)).join('example/payload.json').read
changeset     = Citrus::Core::GithubAdapter.new.create_changeset_from_push_data(payload)
build         = Citrus::Core::Build.new(changeset)
build_service = Citrus::Core::ExecuteBuildService.new
build_service.add_subscriber(Notifier.new)
build_service.start(build)


