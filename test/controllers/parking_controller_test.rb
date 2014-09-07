require 'parking_helper'

class ParkingControllerTest < ActionController::TestCase
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
    %w{ id name description url }.each{|k| assert first_spot.has_key? k}
  end
end
