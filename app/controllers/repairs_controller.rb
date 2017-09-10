class RepairsController < ApplicationController
  # TODO: jbuilder for generating json views
  def index
    render json: Repair.all
  end

  def create
    # TODO: Whitelist parameters
    render json: Repair.create(params[:repair])
  end
end
