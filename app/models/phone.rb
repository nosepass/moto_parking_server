# I keep track of phones used to log in for blacklisty purposes
# The phone identifier string and model information is stored here
# The identifier is typically whatever is returned by the Android
# TelephonyManager#getDeviceId(), which some hardware dependent longass string.
# A hash of detailed build information is also kept alongside the model number.
class Phone < ActiveRecord::Base
end
