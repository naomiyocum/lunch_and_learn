class Api::V1::RecipesController < ApplicationController
  before_action :verify_params

  def index
    recipes = EdamamFacade.recipes_from(params[:country])
    render json: RecipeSerializer.new(recipes)
  end

  private
  
  def verify_params
    if params[:country]
      verify_country
    else
      params[:country] = CountriesFacade.all_countries.sample.name
    end
  end

  def verify_country
    return render json: ErrorSerializer.invalid_country, status: 400 unless Country.valid_country?(params[:country])
  end
end