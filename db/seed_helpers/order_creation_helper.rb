module SeedHelpers
  module OrderCreationHelper
    def self.create_orders!(number_of_orders, shipping: true, date_range: nil)
      date_range ||= 2015..DateTime.now.year
      number_of_orders.times do |order_number|
        Order.create!() unless shipping
        Order.create!(shipped_at: random_date_in_year(date_range)) if shipping
      end
    end

    def self.random_date_in_year(year)
      return rand(DateTime.civil(year.min, 1, 1)..DateTime.civil(year.max, 12, 31)) if year.kind_of?(Range)
      rand(DateTime.civil(year, 1, 1)..DateTime.civil(year, 12, 31))
    end
  end
end