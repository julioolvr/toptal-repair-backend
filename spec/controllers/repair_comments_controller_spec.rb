require 'rails_helper'

RSpec.describe RepairCommentsController, type: :controller do
  describe 'GET #index' do
    it 'returns all comments for a repair' do
      repair = Repair.create(datetime: Time.now, comments: [RepairComment.new, RepairComment.new])
      get :index, params: { repair_id: repair.id }
      expect(JSON.parse(response.body).map { |comment_json| comment_json['id'] }).to eq repair.comments.map(&:id)
    end
  end

  describe 'POST #create' do
    it 'creates a new comment for the given repair' do
      repair = Repair.create(datetime: Time.now)
      expect do
        post :create, params: { repair_id: repair.id, comment: { comment: 'Some comment' } }
      end.to change { repair.comments.count }.from(0).to(1)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the given comment' do
      comment = RepairComment.create(repair: Repair.create(datetime: Time.now))
      expect do
        delete :destroy, params: { id: comment.id }
      end.to change { RepairComment.count }.from(1).to(0)
    end
  end
end
