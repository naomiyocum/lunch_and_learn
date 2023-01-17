class Api::V1::SessionsController < ApplicationController
  before_action :find_user
  
  def create
    if @user.authenticate(params[:password])
      render json: UserSerializer.new(@user)
    else
      render json: ErrorSerializer.incorrect_password, status: 400
    end
  end

  private

  def find_user
    @user = User.find_by(email: params[:email])
    return render json: ErrorSerializer.user_not_found, status: 400 if @user.nil?
  end
end