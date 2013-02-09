require 'minitest/autorun'
require 'mocha/setup'
require 'fakefs/safe'

require 'minitest/reporters'
MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new
