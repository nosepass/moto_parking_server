require 'test_helper'

class LoginControllerTest < ActionController::TestCase
  setup do
    @phone_info = phones(:one)
  end

  test "should automatically create new users" do
    assert_difference('User.count') do
      post :create, credentials: {nickname: "", password: ""}, phone_info: @phone_info.as_json, :format => :json
    end
  end

  test "should not create a user if no phone info is provided" do
    assert_raises ActionController::ParameterMissing do
      post :create, credentials: {nickname: "", password: ""}, :format => :json
    end
    #assert_response :unprocessable_entity

    # post :create, credentials: {nickname: "", password: ""}, phone_info: {some: "garbage"}, :format => :json
    # assert_response :unprocessable_entity
  end
end
