require 'spec_helper'

describe Citrus::Core::Build do

  subject { described_class.new(changeset, uuid) }

  let(:changeset) { fake(:changeset) }
  let(:uuid)      { SecureRandom.uuid }

  it { should respond_to(:changeset) }
  it { should respond_to(:uuid) }

end
