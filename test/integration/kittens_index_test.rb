require 'test_helper'

class KittensIndexTest < ActionDispatch::IntegrationTest
  def setup
    @kitten = kittens(:one)
  end

  test "should display index page" do
    get root_url
    assert_template "kittens/index"
    assert_select "title", text: full_title

    assert_select "a[href=?]", root_path, text: "Home"
    assert_select "a[href=?]", new_kitten_path, text: "New"

    assert_select "h1", text: "Kittens"
    Kitten.all.each do |kitten|
      assert_select "a[href=?]", kitten_path(kitten), text: kitten.name,
                                                      count: 1
      assert_match pretty_decimal(kitten.age).to_s, response.body
      assert_match pretty_decimal(kitten.cuteness).to_s, response.body
      assert_match pretty_decimal(kitten.softness).to_s, response.body
    end
    assert_select "a", text: "edit", count: Kitten.count
    assert_select "a", text: "delete", count: Kitten.count

    assert_difference "Kitten.count", -1 do
      delete kitten_path(@kitten)
    end
  end
end
