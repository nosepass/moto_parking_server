require 'test_helper'

class ParkingSpotTest < ActiveSupport::TestCase
  setup do
    @new_spot = ParkingSpot.new name: "9000th & Bazinga", latitude: 9.88, longitude: 9.88, paid: true, spaces: 0
  end

  # so I fucked the dates up at least once by not calling t.timestamps properly when recreating the table

  test "should set created_at and updated_at on insert" do
    now = Time.now
    @new_spot.save
    assert @new_spot.created_at >= now
    assert @new_spot.updated_at >= now
  end

  test "should touch updated_at of a spot on save" do
    spot = parking_spots(:one)
    old_updated_at = spot.updated_at
    spot.update! description: "fee-bass"
    spot.reload
    assert old_updated_at < spot.updated_at
  end

  test "should not save parking_spots that are erroneously in Danville" do
    # There is a bug in the app (pre v6) that somehow sets the longitude to -122.0 on a move attempt
    # This happens to be in the Danville area, and spots start migrating over there as people attempt to move them
    # Block these update attempts to keep the data clean
    assert_raises ActiveRecord::RecordInvalid do
      spot = parking_spots(:one)
      spot.longitude = -122.0
      spot.save!
    end
  end

end
