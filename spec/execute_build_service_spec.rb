require 'spec_helper'

describe Citrus::Core::ExecuteBuildService do

  subject { described_class.new(workspace_builder, configuration_loader, test_runner) }

  let(:workspace_builder)     { fake(:workspace_builder, create_workspace: path) }
  let(:test_runner)           { fake(:test_runner, start: result) }
  let(:build)                 { fake(:build) }
  let(:configuration_loader)  { fake(:configuration_loader, load_from_path: configuration) }
  let(:configuration)         { fake(:configuration) }
  let(:result)                { fake(:test_result) }
  let(:path)                  { fake }

  context '#start' do
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

    it 'should return build result' do
      expect(subject.start(build)).to eql(result)
    end
  end

end