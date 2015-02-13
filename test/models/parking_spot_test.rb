require 'test_helper'

class ParkingSpotTest < ActiveSupport::TestCase
  setup do
    @new_spot = ParkingSpot.new name: "9000th & Bazinga", latitude: 9.88, longitude: 9.88, paid: true, spaces: 0
  end

  # so I fucked the dates up at least once by not calling t.timestamps properly when recreating the table

  test "should set created_at and updated_at on insert" do
    now = Time.now
    @new_spot.save
    puts "created_at #{@new_spot.created_at} now #{now}"
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

end
