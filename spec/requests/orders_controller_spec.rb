require 'rails_helper'

RSpec.describe OrdersController, type: :request do
  describe 'GET#index' do
    let!(:unshipped_orders) { FactoryBot.create_list(:order, 2) }
    let!(:shipped_order) { FactoryBot.create_list(:order, 1, :shipped) }

    it 'should have the "Orders" title and order id on the page' do 
      get '/orders'
      expect_shipped_and_unshipped_tables_to_be_present
      expect_order_table_to_have_orders(shipped: true)
      expect_order_table_to_have_orders(shipped: false)
    end
  end

  describe 'GET#show' do
    let(:order) { Order.create! }
    it 'should show order details' do
      get "/orders/#{order.id}"
      expect(response.body).to include("Order #{order.id}")
    end
  end

  describe 'GET#add_line_item' do
    it 'should return a new group of inputs for a new line item' do
      get '/orders/add_line_item.js', xhr: true
      expect(response.body).to include('line_item_form')
    end
  end

  def count_orders(shipped: true)
    Nokogiri.parse(response.body).css("#{table_id_selector(shipped: shipped)} > tbody > tr.order_row").count
  end

  def order_table(shipped: true)
    Nokogiri.parse(response.body).css("#{table_id_selector(shipped: shipped)} > tbody")
  end

  def table_id_selector(shipped: true)
    shipped ? '#shipped_orders' : '#unshipped_orders'
  end

  def expect_order_table_to_have_orders(shipped: true)
    order_scope = shipped ? Order.shipped : Order.unshipped
    expect(count_orders(shipped: shipped)).to eq(order_scope.count)
    order_scope.pluck(:id).each do |order_id|
      expect(order_table(shipped: shipped).to_html).to include("/orders/#{order_id}")
    end    
  end

  def expect_shipped_and_unshipped_tables_to_be_present
    expect(response.body).to include(I18n.t('orders.shipped_orders'))
    expect(response.body).to include("shipped_orders")
    expect(response.body).to include(I18n.t('orders.unshipped_orders'))
    expect(response.body).to include("unshipped")
  end
end
