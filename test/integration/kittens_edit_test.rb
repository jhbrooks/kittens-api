require 'test_helper'

class KittensEditTest < ActionDispatch::IntegrationTest
  def setup
    @kitten = kittens(:one)
  end

  test "should display edit page" do
    get edit_kitten_path(@kitten)
    assert_template "kittens/edit"
    assert_select "title", text: full_title("Edit kitten")

    assert_select "a[href=?]", root_path, text: "Home"
    assert_select "a[href=?]", new_kitten_path, text: "New"

    assert_select "h1", text: "Edit kitten"

    assert_select "label", text: "Name:"
    assert_select "label", text: "Age:"
    assert_select "label", text: "Cuteness (1-10):"
    assert_select "label", text: "Softness (1-10):"
    assert_select "input[type=submit]"

    assert_select "a[href=?]", kitten_path(@kitten), text: "delete", count: 1

    assert_difference "Kitten.count", -1 do
      delete kitten_path(@kitten)
    end
  end

  test "should handle invalid submissions" do
    get edit_kitten_path(@kitten)
    assert_template "kittens/edit"
    patch kitten_path(@kitten), kitten: { name: "",
                                          age: "-1",
                                          cuteness: 0,
                                          softness: 11 }
    @kitten.reload
    assert_not_equal "", @kitten.name
    assert_not_equal -1, @kitten.age
    assert_not_equal 0, @kitten.cuteness
    assert_not_equal 11, @kitten.softness

    assert_template "kittens/edit"
    assert_select "div#error_explanation"
    assert_select "div.field_with_errors"
  end

  test "should handle valid submissions" do
    get edit_kitten_path(@kitten)
    assert_template "kittens/edit"
    patch kitten_path(@kitten), kitten: { name: "Valid",
                                          age: "1",
                                          cuteness: 1,
                                          softness: 9.8 }
    @kitten.reload
    assert_equal "Valid", @kitten.name
    assert_equal 1.to_d, @kitten.age
    assert_equal 1.to_d, @kitten.cuteness
    assert_equal 9.8.to_d, @kitten.softness
    
    follow_redirect!
    assert_template "kittens/show"
    assert_not flash.empty?
  end
end
