require 'rails_helper'

RSpec.describe RepairsController, type: :controller do
  describe 'GET #index' do
    it 'returns all repairs' do
      repair_ids = [Repair.create.id]
      get :index
      expect(JSON.parse(response.body).map { |repair_json| repair_json['id'] }).to eq repair_ids
    end
  end

  describe 'POST #create' do
    it 'creates a repair' do
      expect { post :create }.to change { Repair.count }.from(0).to(1)
    end
  end
end
