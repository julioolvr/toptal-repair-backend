require 'rails_helper'

RSpec.describe Repair, type: :model do
  it 'is invalid if it overlaps with another repair' do
    old_repair = Repair.create(datetime: 30.minutes.ago)
    new_repair = Repair.create(datetime: old_repair.datetime + 30.minutes)
    expect(new_repair).to be_invalid
  end
end
