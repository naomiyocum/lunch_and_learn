class Api::V1::FavoritesController < ApplicationController
  before_action :verify_user
  def index
    favorites = Favorite.find_my_favorites(params[:api_key])
    render json: FavoriteSerializer.new(favorites)
  end
  
  def create 
    @user.favorites.create(favorite_params)
    render json: { 'success': 'Favorite added successfully' }, status: :created
  end

  private

  def verify_user
    @user = User.find_by(api_key: params[:api_key])
    return render json: ErrorSerializer.user_not_found, status: 400 if @user.nil?
  end

  def favorite_params
    params.permit(:api_key, :country, :recipe_link, :recipe_title)
  end
end