module SeedHelpers
  module WidgetCreationHelper
    def self.create_widgets!(number_of_widgets)
      number_of_widgets.times do |number|
        Widget.create(name: Faker::Appliance.equipment, msrp: rand(1..100000))
      end 
    end
  end
end