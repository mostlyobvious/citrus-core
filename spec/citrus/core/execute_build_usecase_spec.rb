require 'spec_helper'

class Subscriber
  def build_started(build);           end
  def build_failed(build, result);    end
  def build_succeeded(build, result); end
  def build_aborted(build, reason);   end
end

describe Citrus::Core::ExecuteBuildUsecase do

  subject { described_class.new(workspace_builder, configuration_loader, test_runner) }

  let(:workspace_builder)     { fake(:workspace_builder, create_workspace: path) }
  let(:test_runner)           { fake(:test_runner, start: exit_code) }
  let(:build)                 { fake(:build, output: test_output) }
  let(:configuration_loader)  { fake(:configuration_loader, load_from_path: configuration) }
  let(:configuration)         { fake(:configuration) }
  let(:path)                  { fake }
  let(:subscriber)            { fake(:subscriber) }
  let(:exit_code)             { fake(:exit_code) }
  let(:test_output)           { fake(:test_output) }

  context '#start' do
    before { subject.add_subscriber(subscriber) }

    context do
      it 'should prepare workspace for build' do
        subject.start(build)
        expect(workspace_builder).to have_received.create_workspace(build)
      end

      it 'should read build configuration from workspace' do
        subject.start(build)
        expect(configuration_loader).to have_received.load_from_path(path)
      end

      it 'should execute build script' do
        subject.start(build)
        expect(test_runner).to have_received.start(build, configuration, path)
      end

      it 'should publish build_started event when starting build' do
        subject.start(build)
        expect(subscriber).to have_received.build_started(build)
      end

      it 'should publish build_succeeded event when build has succeeded' do
        stub(exit_code).success? { true }
        stub(test_runner).start(any_args) { exit_code }
        subject.start(build)
        expect(subscriber).to have_received.build_succeeded(build, exit_code)
      end

      it 'should publish build_failed event when build has failed' do
        stub(exit_code).failure? { true }
        stub(test_runner).start(any_args) { exit_code }
        subject.start(build)
        expect(subscriber).to have_received.build_failed(build, exit_code)
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
