require 'spec_helper'

describe Citrus::Core::CreateBuildService do
  include FakeFS::SpecHelpers

  let(:service)        { described_class.new(build_root, uuid_provider) }
  let(:uuid_provider)  { fake(:secure_random, uuid: 'uuid', as: :class)}
  let(:build_root)     { Pathname.new('/build_root') }
  let(:github_adapter) { fake(:github_adapter) }
  let(:changeset)      { fake(:changeset) }
  let(:push_data)      { Pathname.new(File.dirname(__FILE__)).join('../../fixtures/github_push_data.json').read }

  context '#create_from_changeset' do
    subject { service.create_from_changeset(changeset) }

    specify { expect(subject).to be_kind_of(Citrus::Core::Build) }
    specify { expect(subject.changeset).to eq(changeset) }

    context 'output log file' do
      it 'should create output log file under build root' do
        expect(subject.output.path.to_s).to match %r{\A#{build_root}}
      end

      it 'should create output log file in directories partitioned by date and uuid' do
        expect(subject.output.path.to_s).to match %r{\A/build_root/\d{4}/\d{2}/\d{2}\/uuid/}
      end

      it 'should create output log file named build.log' do
        expect(File.basename(subject.output.path)).to eql('build.log')
      end
    end
  end

  context '#create_from_github_push' do
    subject { service.create_from_github_push(push_data, github_adapter) }

    specify { expect(subject).to be_kind_of(Citrus::Core::Build) }

    context 'output log file' do
      it 'should create output log file under build root' do
        expect(subject.output.path.to_s).to match %r{\A#{build_root}}
      end

      it 'should create output log file in directories partitioned by date and uuid' do
        expect(subject.output.path.to_s).to match %r{\A/build_root/\d{4}/\d{2}/\d{2}\/uuid/}
      end

      it 'should create output log file named build.log' do
        expect(File.basename(subject.output.path)).to eql('build.log')
      end
    end
  end

end
