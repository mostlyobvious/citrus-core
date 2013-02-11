require 'minitest/autorun'
require 'mocha/setup'
require 'fakefs/safe'

module FakeFilesystemHelper
  def setup
    super
    FakeFS.activate!
  end

  def teardown
    super
    FakeFS.deactivate!
  end
end

