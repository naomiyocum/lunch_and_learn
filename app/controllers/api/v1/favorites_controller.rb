class Api::V1::FavoritesController < ApplicationController
  before_action :find_user
  def create
    Favorite.new(favorite_params)
    render json: { 'success': 'Favorite added successfully' }, status: :created
  end

  private
  def find_user
    @user = User.find_by(api_key: params[:api_key])
  end

  def favorite_params
    params.permit(:api_key, :country, :recipe_link, :recipe_title)
  end
end