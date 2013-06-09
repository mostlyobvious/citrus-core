require 'spec_helper'

class Subscriber
  def build_started(build);           end
  def build_failed(build, output);    end
  def build_succeeded(build, output); end
  def build_aborted(build, reason);   end
end

describe Citrus::Core::ExecuteBuildService do

  subject { described_class.new(workspace_builder, configuration_loader, test_runner) }

  let(:workspace_builder)     { fake(:workspace_builder, create_workspace: path) }
  let(:test_runner)           { fake(:test_runner, start: fake(:test_result, output: result_output)) }
  let(:build)                 { fake(:build) }
  let(:configuration_loader)  { fake(:configuration_loader, load_from_path: configuration) }
  let(:configuration)         { fake(:configuration) }
  let(:path)                  { fake }
  let(:subscriber)            { fake(:subscriber) }
  let(:success_result)        { Citrus::Core::TestResult.new(0) }
  let(:failure_result)        { Citrus::Core::TestResult.new(1) }
  let(:result_output)         { StringIO.new }

  context '#start' do
    before { subject.add_subscriber(subscriber) }

    context do
      before { subject.start(build) }

      it 'should prepare workspace for build' do
        expect(workspace_builder).to have_received.create_workspace(build)
      end

      it 'should read build configuration from workspace' do
        expect(configuration_loader).to have_received.load_from_path(path)
      end

      it 'should execute build script' do
        expect(test_runner).to have_received.start(configuration, path)
      end

      it 'should publish build_started event when starting build' do
        expect(subscriber).to have_received.build_started(build)
      end

      it 'should publish build_succeeded event when build has succeeded' do
        stub(test_runner).start(any_args) { success_result }
        expect(subscriber).to have_received.build_succeeded(build, result_output)
      end

      it 'should publish build_failed event when build has failed' do
        stub(test_runner).start(any_args) { failure_result }
        expect(subscriber).to have_received.build_failed(build, result_output)
      end
    end

    context 'invalid configuration' do
      let(:reason) { Citrus::Core::ConfigurationError.new }

      before do
        stub(configuration_loader).load_from_path(path) { raise reason }
        expect { subject.start(build) }.to raise_error(Citrus::Core::ConfigurationError)
      end

      it 'should publish build_aborted event when unable to start build due to invalid configuration' do
        expect(subscriber).to have_received.build_aborted(build, reason)
      end
    end
  end

  it 'should allow adding subscribers' do
    expect(subject).to respond_to(:add_subscriber)
  end

end
