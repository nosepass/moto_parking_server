require 'test_helper'

class ParkingSpotsControllerTest < ActionController::TestCase
  setup do
    @spot = parking_spots(:one)
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
    assert spots.length > 0
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
    first_spot = spots[0].with_indifferent_access
    %w{ id name description url latitude longitude }.each{|k| assert first_spot.has_key?(k), "key #{k} not found in json!"}
  end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  test "should create parking_spot" do
    assert_difference('ParkingSpot.count') do
      post :create, parking_spot: { :name => "foo", :description => "bar", :latitude => 0, :longitude => 0, :paid => false , :spaces => 1},
        :format => :json
    end

    assert_response :success
  end

  test "should show parking_spot" do
    get :show, id: @spot, :format => :json
    assert_response :success
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

  test "should destroy parking_spot" do
    assert_difference('ParkingSpot.count', -1) do
      delete :destroy, id: @spot, :format => :json
    end

    assert_response :success
    #assert_redirected_to parking_spots_path
  end
end
