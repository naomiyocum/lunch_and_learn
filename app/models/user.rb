class User < ApplicationRecord
  has_many :favorites
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true

  has_secure_password
  
  after_create :generate_api_key

  private

  def generate_api_key
    update(api_key: SecureRandom.base64)
  end
end