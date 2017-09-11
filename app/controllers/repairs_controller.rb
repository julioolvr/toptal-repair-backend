class RepairsController < ApplicationController
  # TODO: jbuilder for generating json views
  def index
    render json: Repair.all
  end

  def show
    render json: Repair.find(params[:id])
  end

  def create
    render json: Repair.create(repair_params)
  end

  def update
    repair = Repair.find(params[:id])
    repair.update_attributes!(repair_params)
    render json: repair
  end

  def destroy
    Repair.destroy(params[:id])
  end

  private

  def repair_params
    params.require(:repair).permit(:title, :description, :datetime, :is_complete, :is_approved)
  end
end
