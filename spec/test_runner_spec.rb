require 'spec_helper'

describe Citrus::Core::TestRunner do

  subject { described_class.new }

  let(:configuration) { fake(:configuration, build_script: 'w') }
  let(:path)          { fake(:pathname) }
  let(:process)       { fake { ChildProcess::AbstractProcess } }

  context '#start' do
    before { stub(ChildProcess).build(configuration.build_script) { process } }

    it 'spawns child process' do
      expect(process).to have_received.start
    end

    it 'should return process exit code' do
      expect(subject.start(configuration, path)).to be_kind_of(Citrus::Core::ExitCode)
    end

    it 'should wait for process to finish' do
      expect(process).to have_received.wait
    end
  end

end
