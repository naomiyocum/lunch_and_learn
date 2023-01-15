class Favorite < ApplicationRecord
  belongs_to :user
  validates :api_key, :country, :recipe_link, :recipe_title, presence: true

  def self.find_my_favorites(api_key)
    Favorite.where(api_key: api_key)
  end
end