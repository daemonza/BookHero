require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  test "should get scan" do
    get :scan
    assert_response :success
  end

  test "should get list" do
    get :list
    assert_response :success
  end

end
