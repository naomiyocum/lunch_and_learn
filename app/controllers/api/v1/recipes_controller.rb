class Api::V1::RecipesController < ApplicationController
  before_action :verify_params
  include Verifiable

  def index
    recipes = EdamamFacade.recipes_from(params[:country])
    render json: RecipeSerializer.new(recipes)
  end
end