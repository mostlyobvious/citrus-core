require 'spec_helper'

describe Citrus::Core::Build do

  let(:build)     { described_class.new(changeset, uuid) }
  let(:changeset) { fake(:changeset) }
  let(:uuid)      { SecureRandom.uuid }

  specify { expect(build).to respond_to(:changeset) }
  specify { expect(build).to respond_to(:uuid) }
  specify { expect(build).to respond_to(:output) }
  specify { expect(build).to respond_to(:output=) }

  specify { expect(build.output).to respond_to(:read) }
  specify { expect(build.output).to respond_to(:readlines) }
  specify { expect(build.output).to respond_to(:rewind) }

end
