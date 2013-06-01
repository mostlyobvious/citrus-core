require 'spec_helper'

class Subscriber
  def build_started; end
end

describe Citrus::Core::Publisher do

  subject          { described_class.extend(described_class) }
  let(:subscriber) { fake(:subscriber) }

  it 'should notify added subscribers on publish' do
    subject.add_subscriber(subscriber)
    subject.publish(:build_started)

    expect(subscriber).to have_received.build_started
  end

  it 'should pass silently when subscriber does not respond to event' do
    expect {
      subject.add_subscriber(subscriber)
      subject.publish(:foo)
    }.to_not raise_error(NoMethodError)
  end

end
