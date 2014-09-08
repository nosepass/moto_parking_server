require 'test_helper'

class PhoneTest < ActiveSupport::TestCase
  test "should be able to update the access time via updated_at" do
    phone = phones :one
    old_updated_at = phone.updated_at
    Phone.phone_accessed phone
    new_updated_at = Phone.find_by_id(phone.id).updated_at
    assert old_updated_at < new_updated_at
  end
end
