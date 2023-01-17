class Api::V1::LearningResourcesController < ApplicationController
  include Verifiable
  before_action :verify_params

  def show
    resources = LearningResourceFacade.resources_for(params[:country])
    render json: LearningResourceSerializer.new(resources)
  end
end