require 'rails_helper'

RSpec.describe Repair, type: :model do
  it 'is invalid if it overlaps with another repair' do
    old_repair = create(:repair)
    new_repair = build(:repair, datetime: old_repair.datetime + 30.minutes)
    expect(new_repair).to be_invalid
  end
end
