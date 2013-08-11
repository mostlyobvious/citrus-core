require 'spec_helper'

describe Citrus::Core::CommitChanges do

  subject { described_class.new(added, removed, modified) }

  let(:added)    { %w(spec/dummy_spec.rb lib/dummy.rb) }
  let(:removed)  { %w(README.md) }
  let(:modified) { %w(Gemfile Gemfile.lock) }

  it { should respond_to(:added) }
  it { should respond_to(:removed) }
  it { should respond_to(:modified) }

end
