require 'spec_helper'
require 'tmpdir'

class Subscriber
  def output_received(data); end
end

describe Citrus::Core::TestRunner do

  subject { described_class.new }

  let(:configuration) { fake(:configuration, build_script: 'hostname') }
  let(:path)          { Pathname.new('/') }
  let(:process)       { fake { ChildProcess::AbstractProcess } }
  let(:subscriber)    { fake(:subscriber) }

  context '#start' do
    context do
      before { stub(ChildProcess).build(configuration.build_script) { process } }

      it 'spawns child process' do
        expect(process).to have_received.start
      end

      it 'should return test result' do
        expect(subject.start(configuration, path)).to be_kind_of(Citrus::Core::TestResult)
      end

      it 'should wait for process to finish' do
        expect(process).to have_received.wait
      end
    end

    it 'should publish output_received event when process produced output' do
      subject.add_subscriber(subscriber)
      subject.start(configuration, path)
      expect(subscriber).to have_received.output_received(`hostname`)
    end
  end

  it 'should allow adding subscribers' do
    expect(subject).to respond_to(:add_subscriber)
  end

end
