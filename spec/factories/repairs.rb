FactoryGirl.define do
  sequence :repair_datetime do |n|
    n.hours.from_now
  end

  factory :repair do
    datetime { generate(:repair_datetime) }
  end
end
