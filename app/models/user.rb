class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { in: 12..18 }
  validates :password_confirmation, presence: true

  before_save :normalize_email

  def normalize_email
    self.email = email.strip.downcase if email.present?
  end

  def self.authenticate_with_credentials(email, password)
    normalized_email = email.strip.downcase
    user = User.find_by(email: normalized_email)
    user&.authenticate(password) ? user : nil
  end
end
