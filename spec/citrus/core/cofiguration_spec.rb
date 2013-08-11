require 'spec_helper'

describe Citrus::Core::Configuration do

  subject { described_class.new }

  it { should be_a_kind_of(Citrus::Configuration) }
  it { should respond_to(:build_script)  }
  it { should respond_to(:build_script=) }

end
