require 'spec_helper'

describe Citrus::Core::ConfigurationValidator do

  subject { described_class.new }

  let(:valid_configuration) do
    Citrus::Core::Configuration.describe do |config|
      config.build_script = "bundle exec rspec"
    end
  end

  context '#validate' do
    it 'should validate valid example configuration' do
      expect(subject.validate(valid_configuration)).to be_true
    end

    it 'should validate class' do
      expect(subject.validate(Object.new)).to be_false
    end

    it 'should validate build script presence' do
      valid_configuration.build_script = ""
      expect(subject.validate(valid_configuration)).to be_false
    end
  end

end
