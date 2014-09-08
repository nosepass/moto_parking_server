require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should show a user" do
    get :show, id: @user, :format => :json
    assert_response :success
    assert_not_nil assigns(:subject)
  end
end
