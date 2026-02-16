require 'bcrypt'

class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  def authenticate(password)
    BCrypt::Password.new(self.password_digest) == password
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
