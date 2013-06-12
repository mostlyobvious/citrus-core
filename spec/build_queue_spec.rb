require 'spec_helper'

describe Citrus::Core::BuildQueue do

  subject { described_class.new(build_service) }

  let(:build_service) { fake(:execute_build_service) }
  let(:build)         { fake(:build) }

  context '#push' do
    it 'should push build to waiting list' do
      subject.push(build)
      expect(subject.waiting).to include(build)
    end
  end

  context '#pop' do
    it 'should push build from waiting to running list' do
      subject.push(build)
      subject.pop
      expect(subject.waiting).to_not include(build)
      expect(subject.running).to     include(build)
    end
  end

  context '#start' do
    it 'should pop builds and execute them' do
      subject.push(build)
      subject.start
      expect(build_service).to have_received.start(build)
    end
  end

end
