class User < ActiveRecord::Base
  validates :epassword, presence: true,
end
