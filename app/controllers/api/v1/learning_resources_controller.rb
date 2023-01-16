class Api::V1::LearningResourcesController < ApplicationController
  before_action :verify_params
  
  def show
    resource = LearningResourceFacade.resources_for(params[:country])
    render json: LearningResourceSerializer.new(resource)
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