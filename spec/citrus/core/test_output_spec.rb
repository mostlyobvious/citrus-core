require 'spec_helper'

class Subscriber
  def test_output_received(chunk); end
end

describe Citrus::Core::TestOutput do

  let(:test_output) { described_class.new }
  let(:subscriber)  { fake(:subscriber) }

  specify { expect(test_output).to respond_to(:output) }
  specify { expect(test_output).to respond_to(:write) }

  it 'should accumulate test output' do
    chunks = %w(kaka dudu)
    chunks.each { |c| test_output.write(c) }
    expect(test_output.output).to eq(chunks.join)
  end

  it 'should allow adding subscribers' do
    expect(test_output).to respond_to(:add_subscriber)
  end

  it 'should publish test_output_received event on received output' do
    test_output.add_subscriber(subscriber)
    test_output.write('kaka')
    expect(subscriber).to have_received.test_output_received('kaka')
  end

end
