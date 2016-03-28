require 'test_helper'

class KittensNewTest < ActionDispatch::IntegrationTest
  test "should display new page" do
    get new_kitten_path
    assert_template "kittens/new"
    assert_select "title", text: full_title("New kitten")

    assert_select "a[href=?]", root_path, text: "Home"
    assert_select "a[href=?]", new_kitten_path, text: "New"

    assert_select "h1", text: "New kitten"

    assert_select "label", text: "Name:"
    assert_select "label", text: "Age:"
    assert_select "label", text: "Cuteness (1-10):"
    assert_select "label", text: "Softness (1-10):"
    assert_select "input[type=submit]"
  end

  test "should handle invalid submissions" do
    get new_kitten_path
    assert_template "kittens/new"
    assert_no_difference "Kitten.count" do
      post_via_redirect kittens_path, kitten: { name: "",
                                                age: "-1",
                                                cuteness: 0,
                                                softness: 11 }
    end
    assert_template "kittens/new"
    assert_select "div#error_explanation"
    assert_select "div.field_with_errors"
  end

  test "should handle valid submissions" do
    get new_kitten_path
    assert_template "kittens/new"
    assert_difference "Kitten.count", 1 do
      post_via_redirect kittens_path, kitten: { name: "Valid",
                                                age: "1",
                                                cuteness: 1,
                                                softness: 9.8 }
    end
    assert_template "kittens/show"
    assert_not flash.empty?
  end
end
