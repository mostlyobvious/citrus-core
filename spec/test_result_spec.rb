require 'spec_helper'

describe Citrus::Core::TestResult do

  subject { described_class.new(process_handle) }

  let(:process_handle) { fake { ChildProcess::AbstractProcess } }
  let(:exit_code)      { fake }

  context '#result' do
    it 'should wait for process to finish' do
      subject.result
      expect(process_handle).to have_received.wait
    end

    it 'should return process exit code' do
      stub(process_handle).exit_code { exit_code }
      expect(subject.result).to eql(exit_code)
    end
  end

end
