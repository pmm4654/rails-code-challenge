class LineItem < ApplicationRecord
  belongs_to :order, inverse_of: :line_items
  belongs_to :widget

  validates :order, :quantity, :unit_price, :widget, presence: true

end