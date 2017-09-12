FactoryGirl.define do
  factory :repair_comment do
    association :repair, factory: :repair, strategy: :build
  end
end
