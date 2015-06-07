require 'test/unit'

class TC_Time < Test::Unit::TestCase

  def setup
    @now = Time.now
    @after_one_minute = @now + 60.0
    @before_one_minute = @now - 60.0
  end

  def test_operator_equal
    assert_true @now == @now
    assert_false @now == @after_one_minute
    assert_false @now == @before_one_minute
  end
end

class TC_Array < Test::Unit::TestCase

  def test_size
    assert_equal [].size, 0
    assert_equal ['hello'].size, 1
  end
end
