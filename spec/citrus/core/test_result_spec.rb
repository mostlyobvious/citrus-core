require 'spec_helper'

describe Citrus::Core::TestResult do

  it 'should expose exit code' do
    exit_code = 0
    subject   = described_class.new(exit_code)
    expect(subject.exit_code).to eq(exit_code)
  end

  it 'should be successful for zero exit code value' do
    subject = described_class.new(0)
    expect(subject.success?).to be_true
  end

  it 'should be failure for non-zero exit code value' do
    subject = described_class.new(1)
    expect(subject.failure?).to be_true
  end

end
