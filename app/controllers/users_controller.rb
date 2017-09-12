class UsersController < ApplicationController
  after_action :verify_authorized

  def index
    authorize User
    render json: User.all
  end

  def show
    authorize User
    render json: User.find(params[:id])
  end

  def create
    authorize User
    render json: User.create!(user_params)
  end

  def update
    user = User.find(params[:id])
    authorize user
    user.update_attributes!(user_params)
    render json: user
  end

  def destroy
    authorize User
    User.destroy(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
