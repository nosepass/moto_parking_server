require 'securerandom'

# A user. This is usually autocreated, with a generated password
# being issued. All other information is optional, if user a cares
# to create a nickname etc
class User < ActiveRecord::Base
  has_many :created_spots, :class_name => "ParkingSpot", :foreign_key => "created_by"
  has_many :updated_spots, :class_name => "ParkingSpot", :foreign_key => "modified_by"
  validates :epassword, :salt, presence: true
  validates :nickname, :uniqueness => true, :presence => true

  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates :email, :uniqueness => true, :allow_nil => true, :format => EMAIL_REGEX
  
  attr_accessor :password
  validates :password, :confirmation => true
  before_validation :encrypt_password
  after_save :clear_password
  
  # Require logging the phone id on any user operations
  attr_accessor :phone_info
  validates :phone_info, :presence => true
  before_save :update_phone_log


  def generate_nickname!
    suffix = User.count
    self.nickname = "Anon#{suffix}"
  end

  def authenticate(password)
    if self.epassword == BCrypt::Engine.hash_secret(password, self.salt)
      true
    else
      false
    end
  end

  def self.create_new_user(phone_info)
    # require phone info to create user
    phone_device_id = phone_info && phone_info[:device_id]
    phone = Phone.find_by_device_id phone_device_id
    if phone.nil?
      phone = Phone.new phone_info
      if not phone.save
        return nil
      end
    end

    user = User.new
    user.generate_nickname!
    password = user.generate_password
    user.phone_info = phone
    if user.save
      {user:user, password: password}
    else
      nil
    end
  end

  # this creates a randomly generated password for new users
  # that can be overwritten with a user-chosen one
  # this random password is stored on the phone
  def generate_password
    self.password = SecureRandom.hex
  end


  protected

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.epassword = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end

  def update_phone_log
    Phone.phone_accessed phone_info
  end
end
