require 'spec_helper'

describe Citrus::Core::ConfigurationLoader do

  subject { described_class.new(validator) }

  let(:validator) { fake(:configuration_validator) }
  let(:test_root) { Pathname.new(File.dirname(__FILE__)) }
  let(:repo_root) { test_root.join('fixtures/repo') }

  context '#load_from_path' do
    it 'should return configuration when config file found' do
      stub(validator).validate(any_args) { true }
      expect(subject.load_from_path(repo_root)).to be_a_kind_of(Citrus::Core::Configuration)
    end

    it 'should raise when no configuration can be found' do
      expect { subject.load_from_path(test_root) }.to raise_error(Citrus::Core::ConfigurationFileNotFoundError)
    end

    it 'should raise when found configuration is not valid' do
      stub(validator).validate(any_args) { false }
      expect { subject.load_from_path(repo_root) }.to raise_error(Citrus::Core::ConfigurationFileInvalidError)
    end
  end

end
