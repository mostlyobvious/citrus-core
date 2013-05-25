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

    it 'returns result object responding to #result' do
      expect(subject.start(configuration, path)).to respond_to(:result)
    end
  end

end
