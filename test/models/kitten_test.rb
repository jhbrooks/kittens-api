require 'test_helper'

class KittenTest < ActiveSupport::TestCase
  def setup
    @kitten = kittens(:one)
  end

  test "should be valid" do
    assert @kitten.valid?
  end

  test "name should be present" do
    @kitten.name = " "
    assert_not @kitten.valid?
  end

  test "age should be present" do
    @kitten.age = nil
    assert_not @kitten.valid?
  end

  test "age should not be negative" do
    @kitten.age = -1
    assert_not @kitten.valid?
  end

  test "cuteness should be present" do
    @kitten.cuteness = nil
    assert_not @kitten.valid?
  end

  test "cuteness should be between 1 and 10 (inclusive)" do
    @kitten.cuteness = 11
    assert_not @kitten.valid?
  end

  test "softness should be present" do
    @kitten.softness = nil
    assert_not @kitten.valid?
  end

  test "softness should be between 1 and 10 (inclusive)" do
    @kitten.softness = 11
    assert_not @kitten.valid?
  end
end
