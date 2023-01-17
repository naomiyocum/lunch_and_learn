class Api::V1::LearningResourcesController < ApplicationController
  before_action :verify_params

  def show
    resources = LearningResourceFacade.resources_for(params[:country])
    render json: LearningResourceSerializer.new(resources)
  end

  private

  def verify_params
    if params[:country]
      verify_country
    else
      params[:country] = Country.random_country
    end
  end

  def verify_country
    return render json: ErrorSerializer.invalid_country, status: 400 unless Country.valid_country?(params[:country])
  end
end