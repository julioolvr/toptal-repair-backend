require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'role: user' do
    before do
      sign_in create(:user)
    end

    describe 'GET #index' do
      it 'lists all users' do
        get :index
        expect(response).to be_forbidden
      end
    end

    describe 'GET #show' do
      it 'returns a user' do
        id = create(:user).id
        get :show, params: { id: id }
        expect(response).to be_forbidden
      end
    end

    describe 'POST #create' do
      it 'creates a user' do
        post :create, params: { user: { email: 'test@test.com', password: '123456' } }
        expect(response).to be_forbidden
      end
    end

    describe 'PATCH #update' do
      it 'updates a user' do
        id = create(:user).id
        patch :update, params: { id: id, user: { email: 'new@email.com' } }
        expect(response).to be_forbidden
      end
    end

    describe 'DELETE #destroy' do
      it 'deletes a user' do
        id = create(:user).id
        delete :destroy, params: { id: id }
        expect(response).to be_forbidden
      end
    end
  end

  describe 'role: manager' do
    before do
      sign_in create(:user, :manager)
    end

    describe 'GET #index' do
      it 'lists all users' do
        create(:user)
        get :index
        expect(JSON.parse(response.body).map { |user_json| user_json['id'] }).to eq User.pluck(:id)
      end
    end

    describe 'GET #show' do
      it 'returns a user' do
        id = create(:user).id
        get :show, params: { id: id }
        expect(JSON.parse(response.body)['id']).to eq id
      end
    end

    describe 'POST #create' do
      it 'creates a user' do
        expect do
          post :create, params: { user: { email: 'test@test.com', password: '123456' } }
        end.to change { User.count }.by(1)
      end
    end

    describe 'PATCH #update' do
      it 'updates a user' do
        id = create(:user).id
        expect do
          patch :update, params: { id: id, user: { email: 'new@email.com' } }
        end.to(change { User.find(id).email })
      end
    end

    describe 'DELETE #destroy' do
      it 'deletes a user' do
        id = create(:user).id
        expect do
          delete :destroy, params: { id: id }
        end.to change { User.count }.by(-1)
      end
    end
  end
end
