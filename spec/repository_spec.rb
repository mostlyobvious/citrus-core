require 'spec_helper'

describe Citrus::Core::Repository do

  subject   { described_class.new(url) }

  let(:url) { 'file:///repo' }

  it        { should respond_to(:url) }

end
