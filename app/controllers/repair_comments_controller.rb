class RepairCommentsController < ApplicationController
  def index
    render json: Repair.find(params[:repair_id]).comments
  end

  def create
    render json: Repair.find(params[:repair_id]).comments.create!(comment_params)
  end

  def destroy
    RepairComment.destroy(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
