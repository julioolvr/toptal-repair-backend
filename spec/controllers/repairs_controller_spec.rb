require 'rails_helper'

RSpec.describe RepairsController, type: :controller do
  describe 'GET #index' do
    it 'returns all repairs' do
      ids = [create(:repair).id]
      get :index
      expect(JSON.parse(response.body).map { |repair_json| repair_json['id'] }).to eq ids
    end
  end

  describe 'GET #show' do
    it 'returns a repair' do
      id = create(:repair).id
      get :show, params: { id: id }
      expect(JSON.parse(response.body)['id']).to eq id
    end
  end

  describe 'POST #create' do
    it 'creates a repair' do
      expect do
        post :create, params: { repair: { title: 'New repair', datetime: 3.hours.ago } }
      end.to change { Repair.count }.from(0).to(1)
    end
  end

  describe 'PATCH #update' do
    it 'updates a repair' do
      id = create(:repair).id
      expect do
        patch :update, params: { id: id, repair: { title: 'Updated title' } }
      end.to(change { Repair.find(id).title })
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a repair' do
      id = create(:repair).id
      expect do
        delete :destroy, params: { id: id }
      end.to change { Repair.count }.from(1).to(0)
    end
  end
end
