class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password
  validates :password, length: { minimum: 6 }, on: :create

  def self.authenticate_with_credentials(email, password)
    user = User.find_by("lower(email) = ?", email.downcase.strip)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end
end
