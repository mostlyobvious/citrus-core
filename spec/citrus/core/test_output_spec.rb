require 'spec_helper'

describe Citrus::Core::TestOutput do

  let(:test_output) { described_class.new }

  specify { expect(test_output).to respond_to(:output) }
  specify { expect(test_output).to respond_to(:write) }

  it 'should accumulate test output' do
    test_output.write('kaka')
    test_output.write('dudu')
    expect(test_output.output).to eq('kakadudu')
  end

end
