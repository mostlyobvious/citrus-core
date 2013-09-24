require 'spec_helper'

describe Citrus::Core::TestOutput do

  let(:test_output) { described_class.new }

  specify { expect(test_output).to respond_to(:read)  }
  specify { expect(test_output).to respond_to(:write) }

  it 'should accumulate test output' do
    chunks = %w(kaka dudu)
    chunks.each { |c| test_output.write(c) }
    expect(test_output.read).to eq(chunks.join)
  end

end
