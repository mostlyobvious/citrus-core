require 'spec_helper'

describe Citrus::Core::TestResult do

  it 'should be successful for zero exit code value' do
    subject = described_class.new(0)
    expect(subject.success?).to be_true
  end

  it 'should be failure for non-zero exit code value' do
    subject = described_class.new(1)
    expect(subject.failure?).to be_true
  end

  it 'should have IO like output' do
    subject = described_class.new(0)
    expect(subject.output).to respond_to(:rewind)
  end

end
