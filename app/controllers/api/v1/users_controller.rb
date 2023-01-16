class Api::V1::UsersController < ApplicationController
  def create
    new_user = User.new(user_params)
    if new_user.save
      render json: UserSerializer.new(new_user), status: :created
    else
      render json: ErrorSerializer.user_creation_error(new_user.errors), status: 400
    end
  end

  private

  def user_params
    params.permit(:name, :email)
  end
end