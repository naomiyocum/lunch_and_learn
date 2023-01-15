class Favorite < ApplicationRecord
  belongs_to :user
  validates :api_key, :country, :recipe_link, :recipe_title, presence: true
end