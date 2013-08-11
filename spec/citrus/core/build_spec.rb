require 'spec_helper'
require 'securerandom'

describe Citrus::Core::Build do

  subject { described_class.new(changeset, uuid, output) }

  let(:changeset) { fake(:changeset) }
  let(:uuid)      { SecureRandom.uuid }
  let(:output)    { StringIO.new }

  specify { expect(subject).to respond_to(:changeset) }
  specify { expect(subject).to respond_to(:uuid) }
  specify { expect(subject).to respond_to(:output) }

end
