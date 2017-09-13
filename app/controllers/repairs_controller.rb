class RepairsController < ApplicationController
  # TODO: jbuilder for generating json views
  after_action :verify_authorized, except: :index

  def index
    render json: policy_scope(Repair)
  end

  def show
    repair = Repair.find(params[:id])
    authorize repair
    render json: repair
  end

  def create
    authorize Repair
    render json: Repair.create!(repair_params)
  end

  def update
    repair = Repair.find(params[:id])
    authorize repair
    repair.update_attributes!(repair_params)
    render json: repair
  end

  def destroy
    authorize Repair
    Repair.destroy(params[:id])
  end

  private

  def repair_params
    params.require(:repair).permit(:title, :description, :datetime, :is_complete, :is_approved)
  end
end
