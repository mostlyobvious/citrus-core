require 'spec_helper'

describe Citrus::Core::QueuedBuilder do

  subject { described_class.new(build_service, queue) }

  let(:build_service) { fake(:execute_build_service) }
  let(:build)         { fake(:build) }
  let(:queue)         { Queue.new }

  context '#start' do
    it 'should execute dequeued build' do
      queue.push(build)
      subject.start
      expect(build_service).to have_received.start(build)
    end
  end

end
