require 'test_helper'

class KittensControllerTest < ActionController::TestCase
  def setup
    @kitten = kittens(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, id: @kitten
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should post create" do
    post :create, kitten: { name: "Test", age: "10",
                            cuteness: 5, softness: 7.5 }
    assert_response :redirect
  end

  test "should get edit" do
    get :edit, id: @kitten
    assert_response :success
  end

  test "should patch update" do
    patch :update, id: @kitten, kitten: { name: "Test", age: "10",
                                          cuteness: 5, softness: 7.5 }
    assert_response :redirect
  end

  test "should delete destroy" do
    delete :destroy, id: @kitten
    assert_response :redirect
  end
end
