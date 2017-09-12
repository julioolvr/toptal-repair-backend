require 'rails_helper'

RSpec.describe UserPolicy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:manager) { create(:user, :manager) }

  permissions :index?, :show?, :create?, :update?, :destroy? do
    it { should_not permit(user, create(:user)) }
    it { should permit(manager, create(:user)) }
  end
end
