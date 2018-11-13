FactoryBot.define do
  factory :line_item do
    widget
    order
    quantity { rand(20) }
    unit_price { rand(50) }
  end
end
