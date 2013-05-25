require 'spec_helper'

describe Citrus::Core::Changeset do

  subject { described_class.new(repository, commits) }

  let(:repository) { fake(:repository, url: 'file:///repo') }
  let(:commits)    { [fake(:commit, sha: 'abc'), fake(:commit, sha: 'def')] }

  it { should respond_to(:repository) }
  it { should respond_to(:commits) }
  its(:repository_url) { should == 'file:///repo' }
  its(:head)           { should == 'def' }

end
