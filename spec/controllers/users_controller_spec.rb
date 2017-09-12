require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'lists all users' do
      ids = [User.create!(email: 'test@test.com', password: '123456').id]
      get :index
      expect(JSON.parse(response.body).map { |user_json| user_json['id'] }).to eq ids
    end
  end

  describe 'GET #show' do
    it 'returns a user' do
      id = User.create!(email: 'test@test.com', password: '123456').id
      get :show, params: { id: id }
      expect(JSON.parse(response.body)['id']).to eq id
    end
  end

  describe 'POST #create' do
    it 'creates a user' do
      expect do
        post :create, params: { user: { email: 'test@test.com', password: '123456' } }
      end.to change { User.count }.from(0).to(1)
    end
  end

  describe 'PATCH #update' do
    it 'updates a user' do
      id = User.create!(email: 'test@test.com', password: '123456').id
      expect do
        patch :update, params: { id: id, user: { email: 'new@email.com' } }
      end.to(change { User.find(id).email })
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a user' do
      id = User.create!(email: 'test@test.com', password: '123456').id
      expect do
        delete :destroy, params: { id: id }
      end.to change { User.count }.from(1).to(0)
    end
  end
end
