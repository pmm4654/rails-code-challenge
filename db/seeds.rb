require Rails.root.join('db', 'seed_helpers', 'order_creation_helper.rb')
include SeedHelpers

OrderCreationHelper::create_orders!(5, shipping: false)
OrderCreationHelper::create_orders!(5)
