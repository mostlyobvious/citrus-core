require 'spec_helper'

class Subscriber
  def build_output_received(build, data); end
end

describe Citrus::Core::TestRunner do

  subject { described_class.new }

  let(:configuration) { fake(:configuration, build_script: 'hostname') }
  let(:path)          { Pathname.new('/') }
  let(:process)       { fake(io: process_io, exit_code: exit_code) { ChildProcess::AbstractProcess } }
  let(:process_io)    { fake { ChildProcess::AbstractIO } }
  let(:exit_code)     { fake(:fixnum) }
  let(:subscriber)    { fake(:subscriber) }
  let(:build)         { fake(:build, output: build_output) }
  let(:build_output)  { fake { [File, StringIO] } }

  context '#start' do
    context do
      before { stub(ChildProcess).build(configuration.build_script) { process } }

      it 'spawns child process' do
        subject.start(build, configuration, path)
        expect(process).to have_received.start
      end

      it 'should return test result' do
        expect(subject.start(build, configuration, path)).to be_kind_of(Citrus::Core::TestResult)
      end

      it 'should wait for process to finish' do
        subject.start(build, configuration, path)
        expect(process).to have_received.wait
      end
    end

    it 'should publish build_output_received event when process produced output' do
      subject.add_subscriber(subscriber)
      subject.start(build, configuration, path)
      expect(subscriber).to have_received.build_output_received(build, `hostname`)
    end

    it 'should write process ouput to build' do
      subject.start(build, configuration, path)
      expect(build_output).to have_received.write(`hostname`)
    end
  end

  it 'should allow adding subscribers' do
    expect(subject).to respond_to(:add_subscriber)
  end

end
