class Api::V1::LearningResourcesController < ApplicationController
  def show
    resource = LearningResourceFacade.resources_for(params[:country])
    render json: LearningResourceSerializer.new(resource)
  end
end