FactoryBot.define do
  factory :order do
    trait :shipped do
      shipped_at { DateTime.now }
    end
  end
end
