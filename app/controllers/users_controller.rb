class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def show
    render json: User.find(params[:id])
  end

  def create
    render json: User.create!(user_params)
  end

  def update
    user = User.find(params[:id])
    user.update_attributes!(user_params)
    render json: user
  end

  def destroy
    User.destroy(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
