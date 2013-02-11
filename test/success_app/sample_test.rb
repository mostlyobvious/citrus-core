require 'test/unit'
require 'sample_app'

class SampleTest < Test::Unit::TestCase
  def setup
    @sample_app = SampleApp.new
  end
  def test_hello_world
    assert_equal "hello world", @sample_app.hello_world
  end
end
