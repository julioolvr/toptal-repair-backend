require 'rails_helper'

RSpec.describe RepairsController, type: :controller do
  describe 'role: user' do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    describe 'GET #index' do
      it 'returns only the repairs assigned to the user' do
        allowed_repair = create(:repair, assignee: user)
        forbidden_repair = create(:repair)

        get :index

        ids = JSON.parse(response.body).map { |repair_json| repair_json['id'] }
        expect(ids).to include allowed_repair.id
        expect(ids).not_to include forbidden_repair.id
      end
    end

    describe 'GET #show' do
      it 'returns a repair if the user is assigned to it' do
        id = create(:repair, assignee: user).id
        get :show, params: { id: id }
        expect(JSON.parse(response.body)['id']).to eq id
      end

      it 'is forbidden if the user is not assigned to the repair' do
        id = create(:repair).id
        get :show, params: { id: id }
        expect(response).to be_forbidden
      end
    end

    describe 'POST #create' do
      it 'can\'t create a repair' do
        post :create, params: { repair: { title: 'New repair', datetime: 3.hours.ago } }
        expect(response).to be_forbidden
      end
    end

    describe 'PATCH #update' do
      it 'can update a repair if the user is assigned to it' do
        id = create(:repair, assignee: user).id
        expect do
          patch :update, params: { id: id, repair: { title: 'Updated title' } }
        end.to(change { Repair.find(id).title })
      end

      it 'is forbidden if the user is not assigned to the repair' do
        id = create(:repair).id
        patch :update, params: { id: id, repair: { title: 'Updated title' } }
        expect(response).to be_forbidden
      end
    end

    describe 'DELETE #destroy' do
      it 'can\'t delete a repair' do
        id = create(:repair).id
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
end
