# I keep track of phones used to log in for blacklisty purposes
# The phone identifier string and model information is stored here
# The identifier is typically whatever is returned by the Android
# TelephonyManager#getDeviceId(), which some hardware dependent longass string.
# A hash of detailed build information is also kept alongside the model number.
class Phone < ActiveRecord::Base
  validates :device_id, :model, :build_json, presence: true
  validates :device_id, :uniqueness => true

  def self.phone_accessed(pinfo)
    phone = Phone.find_by_device_id pinfo[:device_id]
    if phone
      phone.touch
      phone.save
    else
      phone = Phone.new :device_id => pinfo[:device_id], :model => pinfo[:model], :build_json => pinfo[:build]
      phone.save!
    end
  end
end
