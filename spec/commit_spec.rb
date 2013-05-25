require 'spec_helper'

describe Citrus::Core::Commit do

  subject { described_class.new(sha, author, message, timestamp, changes, url) }

  let(:author)    { 'John Doe' }
  let(:sha)       { 'abc' }
  let(:message)   { 'Fixes, obviously.' }
  let(:timestamp) { Time.now }
  let(:url)       { 'https://github.com/octokitty/testing/commit/c441029cf673f84c8b7db52d0a5944ee5c52ff89' }
  let(:changes)   { fake(:commit_changes) }

  it { should respond_to(:sha) }
  it { should respond_to(:author) }
  it { should respond_to(:message) }
  it { should respond_to(:timestamp) }
  it { should respond_to(:changes) }
  it { should respond_to(:url) }

end
