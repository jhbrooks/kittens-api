require 'test_helper'

class KittensShowTest < ActionDispatch::IntegrationTest
  def setup
    @kitten = kittens(:one)
  end

  test "should display show page" do
    get kitten_path(@kitten)
    assert_template "kittens/show"
    assert_select "title", text: full_title(@kitten.name)

    assert_select "a[href=?]", root_path, text: "Home"
    assert_select "a[href=?]", new_kitten_path, text: "New"

    assert_match @kitten.name, response.body
    assert_match pretty_decimal(@kitten.age).to_s, response.body
    assert_match pretty_decimal(@kitten.cuteness).to_s, response.body
    assert_match pretty_decimal(@kitten.softness).to_s, response.body
    assert_select "a[href=?]", edit_kitten_path(@kitten), text: "edit",
                                                          count: 1
    assert_select "a[href=?]", kitten_path(@kitten), text: "delete", count: 1

    assert_difference "Kitten.count", -1 do
      delete kitten_path(@kitten)
    end
  end

  test "should function as an API through JSON" do
    get kitten_path(@kitten), format: :json
    assert_response :success

    json = JSON.parse(response.body, symbolize_names: true)
    assert_equal @kitten.name, json[:name]
    assert_equal @kitten.age.to_s, json[:age]
    assert_equal @kitten.cuteness.to_s, json[:cuteness]
    assert_equal @kitten.softness.to_s, json[:softness]
  end
end
