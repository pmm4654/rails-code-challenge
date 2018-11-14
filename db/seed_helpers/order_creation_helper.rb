module SeedHelpers
  module OrderCreationHelper
    def self.create_orders!(number_of_orders, shipping: true, date_range: nil)
      date_range ||= 2015..DateTime.now.year
      number_of_orders.times do |order_number|
        Order.create!() unless shipping
        Order.create!(shipped_at: random_date_in_year(date_range), line_items_attributes: build_widgets) if shipping
      end
    end

    def self.build_widgets 
      widgets = []
      rand(10).times do 
        widgets << {widget_id: widget_ids.sample, quantity: rand(100), unit_price: (100)}
      end
      widgets
    end

    def self.random_date_in_year(year)
      return rand(DateTime.civil(year.min, 1, 1)..DateTime.civil(year.max, 12, 31)) if year.kind_of?(Range)
      rand(DateTime.civil(year, 1, 1)..DateTime.civil(year, 12, 31))
    end

    def self.widget_ids
      @widget_ids ||= Widget.pluck(:id)
    end
  end
end