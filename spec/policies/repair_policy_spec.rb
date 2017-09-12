require 'rails_helper'

RSpec.describe RepairPolicy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:manager) { create(:user, :manager) }

  permissions :show?, :update? do
    it { should permit(user, create(:repair)) }
    it { should permit(manager, create(:repair)) }
  end

  permissions :create?, :destroy? do
    it { should_not permit(user) }
    it { should permit(manager) }
  end
end
