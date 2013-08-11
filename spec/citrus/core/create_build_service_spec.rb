require 'spec_helper'

describe Citrus::Core::CreateBuildService do

  let(:service)        { described_class.new }
  let(:github_adapter) { fake(:github_adapter) }
  let(:changeset)      { fake(:changeset) }
  let(:push_data)      { Pathname.new(File.dirname(__FILE__)).join('../../fixtures/github_push_data.json').read }

  context '#create_from_changeset' do
    subject { service.create_from_changeset(changeset) }

    specify { expect(subject).to be_kind_of(Citrus::Core::Build) }
    specify { expect(subject.changeset).to eq(changeset) }
  end

  context '#create_from_github_push' do
    subject { service.create_from_github_push(push_data, github_adapter) }

    specify { expect(subject).to be_kind_of(Citrus::Core::Build) }
  end

end
