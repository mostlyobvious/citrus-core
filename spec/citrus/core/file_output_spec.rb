require 'spec_helper'

class Subscriber
  def test_output_received(chunk); end
end

describe Citrus::Core::FileOutput do
  include FakeFS::SpecHelpers

  let(:file_output) { described_class.new(file_name, root_path) }
  let(:root_path)   { Pathname.new('/output_root') }
  let(:file_name)   { 'dummy.log' }
  let(:subscriber)  { fake(:subscriber) }

  specify { expect(file_output).to respond_to(:write) }
  specify { expect(file_output).to respond_to(:read)  }
  specify { expect(file_output).to respond_to(:path)  }

  it 'should return empty string when output empty' do
    expect(file_output.read).to eq('')
  end

  it 'should accumulate test output' do
    pending 'this will not work on fake_fs'
    chunks = %w(kaka dudu)
    chunks.each { |c| file_output.write(c) }
    expect(file_output.read).to eq(chunks.join)
  end

  it 'should provide path to allow direct access to ouput file' do
    expect(file_output.path.to_s).to eq('/output_root/dummy.log')
  end

  it 'should allow adding subscribers' do
    expect(file_output).to respond_to(:add_subscriber)
  end

  it 'should publish file_output_received event on received output' do
    file_output.add_subscriber(subscriber)
    file_output.write('kaka')
    expect(subscriber).to have_received.test_output_received('kaka')
  end

end
