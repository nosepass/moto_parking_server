require 'test_helper'

class LoginControllerTest < ActionController::TestCase
  setup do
    @phone_info = phones(:one)
  end

  test "should automatically create new users" do
    assert_difference('User.count') do
      post :create, credentials: {nickname: "", password: ""}, phone_info: @phone_info.as_json, :format => :json
    end
    assert_response :success
  end

  test "should not create a user if no phone info is provided" do
    assert_no_difference('User.count') do
      assert_raises ActionController::ParameterMissing do
        post :create, credentials: {nickname: "", password: ""}, :format => :json
      end
    end
    #assert_response :unprocessable_entity

    # post :create, credentials: {nickname: "", password: ""}, phone_info: {some: "garbage"}, :format => :json
    # assert_response :unprocessable_entity
  end

  test "should lookup existing users" do
    assert_no_difference('User.count') do
      post :create, credentials: {nickname: "MyString", password: "foo"}, phone_info: @phone_info.as_json, :format => :json
    end
    assert_response :redirect
  end

  test "should forbid existing users with wrong password" do
    post :create, credentials: {nickname: "MyString", password: "wrongpassword"}, phone_info: @phone_info.as_json, :format => :json
    assert_response :forbidden
  end

  test "should store the user id in session" do
    session[:user_id] = 0
    post :create, credentials: {nickname: "MyString", password: "foo"},  phone_info: @phone_info.as_json, :format => :json
    assert_equal users(:one).id, session[:user_id]
  end
end
