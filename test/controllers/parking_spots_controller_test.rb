require 'test_helper'

class ParkingSpotsControllerTest < ActionController::TestCase
  setup do
    @spot = parking_spots(:one)
    @expected_keys = %w{ id name description latitude longitude spaces paid spots_available_date }
    session[:user_id] = users(:one).id # authenticate
  end

  test "should forbid you if you're not logged in" do
    session[:user_id] = nil
    get :index, :format => :json
    assert_response :forbidden

    assert_no_difference('ParkingSpot.count') do
      post :create, parking_spot: { :name => "foo", :description => "bar", :latitude => 0, :longitude => 0, :paid => false , :spaces => 1},
        :format => :json
    end

    assert_response :forbidden
  end

  test "should get index" do
    get :index, :format => :json
    assert_response :success
    assert_not_nil assigns(:spots)
  end

  test "should cough up at least one fixture parking spot from index" do
    get :index, :format => :json
    spots = assigns :spots
    assert spots.length > 0, "0 spots were returned!"
  end

  test "should cough up valid json" do
    get :index, :format => :json
    assert_nothing_raised(JSON::ParserError) do
      JSON.parse @response.body
    end
  end

  test "should have json elements with the expected values" do
    get :index, :format => :json
    spots = JSON.parse @response.body
    assert spots.length > 0, "bad test data!"
    first_spot = spots[0].with_indifferent_access
    @expected_keys.each{|k| assert first_spot.has_key?(k), "key #{k} not found in json!"}
    assert first_spot.has_key?("url"), "key url not found in json!"
  end

  test "should not show deleted spots" do
    deleted_spot = parking_spots :three
    assert deleted_spot.deleted, "the test data is bad"
    get :index, :format => :json
    spots = JSON.parse @response.body
    spots.each do |spot|
      assert_not_equal deleted_spot.id, spot.with_indifferent_access[:id] , "a deleted spot showed up when it shouldn't have!"
    end
  end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  test "should create parking_spot" do
    assert_difference('ParkingSpot.count') do
      post :create, parking_spot: {
          :id => "d3d4f3e8-b3b8-11e4-943c-0021ccb87d16",
          :name => "foo", :description => "bar",
          :latitude => 0, :longitude => 0, :paid => false , :spaces => 1
          },
        :format => :json
    end

    assert_response :success
  end

  test "should reject parking_spots without the required fields" do
    post :create, parking_spot: { :description => "bar" },
      :format => :json
    assert_response :unprocessable_entity
    post :create, parking_spot: { :latitude => 0, :longitude => 0, :paid => false , :spaces => 1},
        :format => :json
    assert_response :unprocessable_entity
  end

  test "should show parking_spot" do
    get :show, id: @spot, :format => :json
    assert_response :success
  end

  test "should show json element with the expected values" do
    get :show, id: @spot, :format => :json
    spot = JSON.parse @response.body
    @expected_keys.each{|k| assert spot.has_key?(k), "key #{k} not found in json!"}
  end

  # test "should get edit" do
  #   get :edit, id: @spot
  #   assert_response :success
  # end

  test "should update parking_spot" do
    patch :update, id: @spot, parking_spot: { :name => "foo2", :description => "bar2", :latitude => 0, :longitude => 0, :paid => false , :spaces => 1},
      :format => :json
    assert_response :success
    #assert_redirected_to parking_spots_path(assigns(:parking_spot))
  end

  test "should reject updates to spots that don't exist yet" do
    assert_raises(ActiveRecord::RecordNotFound) do
      patch :update, id: '33332e5a-dc83-48c9-ad92-28a99095b47c',
        parking_spot: { :name => "foo3", :latitude => 0, :longitude => 0, :spaces => 1},
        :format => :json
    end
  end

  test "should destroy parking_spot" do
    assert !@spot.deleted, "spot was in deleted state already! Cannot test!"
    delete :destroy, id: @spot, :format => :json
    @spot.reload
    assert @spot.deleted, "spot was not deleted!"

    assert_response :success
  end

  test "should log which user created a parking_spot" do
    assert_equal users(:one).id, session[:user_id], "the wrong user is logged in!"
    post :create, parking_spot: { :name => "foo", :description => "bar", :latitude => 0, :longitude => 0, :paid => false , :spaces => 1},
      :format => :json
    assert_response :success
    new_spot_json = JSON.parse(@response.body).with_indifferent_access
    new_spot = ParkingSpot.find new_spot_json[:id]
    msg = "the created_by id is not the logged-in user's id!"
    msg2 = "the updated_by id is not the logged-in user's id!"
    assert_not_nil new_spot.created_by, msg
    assert_not_nil new_spot.updated_by, msg2
    assert_equal users(:one).id, new_spot.created_by.id, msg
    assert_equal users(:one).id, new_spot.updated_by.id, msg2
  end

  test "should log which user updated a parking_spot" do
    assert_equal users(:one).id, session[:user_id], "the wrong user is logged in!"
    @spot.update! updated_by: users(:two)
    patch :update, id: @spot, parking_spot: { :name => "foo2" },
      :format => :json
    @spot.reload
    assert_equal users(:one).id, @spot.updated_by.id, "the id was not changed to the logged-in user's id!"
  end
end
