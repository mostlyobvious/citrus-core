require 'spec_helper'

describe Citrus::Core::WorkspaceBuilder do

  subject { described_class.new(build_root, code_fetcher) }

  let(:build)          { fake(:build) }
  let(:changeset)      { fake(:changeset) }
  let(:code_fetcher)   { fake(:cached_code_fetcher) }

  context '#create_workspace' do
    include FakeFS::SpecHelpers

    let(:result) { subject.create_workspace(build) }

    context do
      let(:build_root)     { fake(:pathname) }
      let(:workspace_path) { fake(:pathname) }

      before do
        stub(build_root).join(any_args) { workspace_path }
        stub(build).changeset           { changeset }
        result
      end

      it 'should return workspace path' do
        expect(result).to eql(workspace_path)
      end

      it 'should fetch code needed for build into workspace' do
        expect(code_fetcher).to have_received.fetch(changeset, workspace_path)
      end
    end

    context do
      let(:build_root) { Pathname.new('/build_root') }
      let(:uuid)       { SecureRandom.uuid }

      before { stub(build).uuid { uuid } }

      it 'should create build directory under build root' do
        expect(result.to_s).to match %r{\A#{build_root}}
      end

      it 'should create workspace in directories partitioned by date' do
        expect(result.dirname.to_s).to match %r{\A/build_root/\d{4}/\d{2}/\d{2}\Z}
      end

      it 'should create workspace named after builds uuid' do
        expect(result.basename.to_s).to eql(uuid)
      end
    end
  end

end
