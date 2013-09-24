require 'spec_helper'
require 'tmpdir'

describe Citrus::Core::WorkspaceBuilder do

  subject { described_class.new(build_root, code_fetcher) }

  let(:build)          { fake(:build, uuid: uuid, changeset: changeset) }
  let(:uuid)           { SecureRandom.uuid }
  let(:changeset)      { fake(:changeset) }
  let(:code_fetcher)   { fake(:cached_code_fetcher) }
  let(:build_root)     { Dir.mktmpdir('build_root') }

  context '#create_workspace' do
    let(:result) { subject.create_workspace(build) }

    it 'should create build directory under build root' do
      expect(result).to start_with(build_root)
    end

    it 'should create workspace in directories partitioned by date' do
      expect(File.dirname(result)).to match(%r{/\d{4}/\d{2}/\d{2}\Z})
    end

    it 'should create workspace named after builds uuid' do
      expect(File.basename(result)).to eql(uuid)
    end

    it 'should fetch code needed for build into workspace' do
      stub(Time).now { Time.at(0) }
      result
      expect(code_fetcher).to have_received.fetch(changeset, "#{build_root}/1970/01/01/#{uuid}")
    end

  end

end
