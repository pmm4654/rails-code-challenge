class Widget < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def self.select_options
    order(:name).pluck(:name, :id)
  end
end
