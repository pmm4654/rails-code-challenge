FactoryBot.define do
  factory :widget do
    trait :cheap do
      name { "Cheap Item No: #{rand(500)}" }
      msrp { rand(1..500) }
    end
    trait :expensive do
      name { "Expensive Item No: #{rand(500)}" }
      msrp { rand(500000..1000000)  }
    end
  end
end
