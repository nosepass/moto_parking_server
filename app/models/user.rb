# A user. This is usually autocreated, with a generated password
# being issued. All other information is optional, if user a cares
# to create a nickname etc
class User < ActiveRecord::Base
  validates :epassword, :salt, presence: true
end
