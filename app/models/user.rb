class User < ApplicationRecord
  has_secure_password

  def self.generate_auth_token
    self.authenication_token = SecureRandom.hex(10)
    self.authentication_token_expiry = DateTime.now + 7.day
  end
end
