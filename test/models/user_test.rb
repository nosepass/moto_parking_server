require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @dummy_new_user = User.new :password => "foo", :nickname => "somerandonick", :phone_info => phones(:one)
  end

  test "should encrypt password" do
    @dummy_new_user.save!
    assert_not_nil @dummy_new_user.epassword
    assert_not_nil @dummy_new_user.salt
  end

  test "should clear out the cleartext password after encrypting" do
    @dummy_new_user.save!
    assert_nil @dummy_new_user.password
  end

  test "should touch updated_at of a phone to indicate access time" do
    phone_id = phones(:one).id
    old_updated_at = phones(:one).updated_at
    @dummy_new_user.save!
    new_updated_at = Phone.find_by_id(phone_id).updated_at
    assert old_updated_at < new_updated_at
  end

  test "should be able to generate an anonymous nickname for people not paying attention" do
    old_nick = @dummy_new_user.nickname
    @dummy_new_user.generate_nickname!
    @dummy_new_user.save!
    assert_not_equal @dummy_new_user.nickname, old_nick
    assert_not_nil @dummy_new_user.nickname
  end

  test "should be able to authenticate a user by nickname and password" do
    nick = users(:one).nickname
    user = User.authenticate(nick, "foo")
    assert_not_nil user
    assert_equal user.nickname, nick
  end

  test "should not be able to authenticate with the wrong password" do
    nick = users(:one).nickname
    user = User.authenticate(nick, "foobar")
    assert_nil user
  end

  test "should not be able to authenticate with no nick" do
    user = User.authenticate(nil, "foobar")
    assert_nil user
  end

  test "should be able generate a random password" do
    user = User.new
    assert_nil user.password
    user.generate_password
    assert_not_nil user.password
  end

  test "should be able automatically generate a new user" do
    phone_info = phones :one
    assert_difference('User.count') do
      User.create_new_user phone_info
    end
  end

  test "should return the automatically generated user's nickname and password" do
    phone_info = phones :one
    userinfo = User.create_new_user phone_info
    assert_not_nil userinfo
    assert userinfo[:user].nickname.is_a? String
    assert userinfo[:password].is_a? String
  end

  test "should fail to generate a new user without phone info" do
    result = User.create_new_user nil
    assert_nil result
  end
end
