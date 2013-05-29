require 'spec_helper'

describe Citrus::Core::GithubAdapter do

  subject { described_class.new }

  let(:push_data) { Pathname.new(File.dirname(__FILE__)).join('fixtures/github_push_data.json').read }

  context '#create_changeset_from_push_data' do
    let(:changeset) { subject.create_changeset_from_push_data(push_data) }

    specify { expect(changeset.repository_url).to eql('https://github.com/octokitty/testing') }
    specify { expect(changeset.head).to eql('1481a2de7b2a7d02428ad93446ab166be7793fbb') }
  end

end
