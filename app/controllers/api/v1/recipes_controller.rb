class Api::V1::RecipesController < ApplicationController
  def index
    recipes = EdamamFacade.recipes_from(params[:country])
    render json: RecipeSerializer.new(recipes)
  end
end