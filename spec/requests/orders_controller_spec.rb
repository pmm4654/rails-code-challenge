require 'rails_helper'

RSpec.describe OrdersController, type: :request do
  describe 'GET#index' do
    let!(:unshipped_orders) { FactoryBot.create_list(:order, 2) }
    let!(:shipped_order) { FactoryBot.create_list(:order, 1, :shipped) }

    it 'should have shipped and unshipped order lists' do 
      get '/orders'
      expect_shipped_and_unshipped_tables_to_be_present
      expect_order_table_to_have_orders(shipped: true)
      expect_order_table_to_have_orders(shipped: false)
    end
  end

  describe 'PUT#create' do
    let(:widget) { FactoryBot.create(:widget, :cheap) }
    it 'should have the "Orders" title and order id on the page' do 
      params = {"order"=>{
                  "line_items_attributes"=>{"0"=>{"widget_id"=>"#{widget.id}", "quantity"=>"21", "unit_price"=>"12"}}}}
      expect_to_create_an_order_with_1_line_item do
        post("/orders", params: params)
      end
    end
  end

  describe 'PATCH#update' do
    let(:widget) { FactoryBot.create(:widget, :cheap) }
    let(:order) { FactoryBot.create(:order)  }
    let!(:line_item) { FactoryBot.create(:line_item, order: order, widget: widget, quantity: 2) }

    Order::SETTING_ACCESSOR_WHITELIST.each do |setting|
      it 'should have the "Orders" title and order id on the page' do
        patch("/orders/#{order.id}/update_settings.js", params: {setting: setting})
        expect(order.reload.send(setting)).to eq(true)
      end
    end
  end


  describe 'PATCH#update' do
    let(:widget) { FactoryBot.create(:widget, :cheap) }
    let(:order) { FactoryBot.create(:order)  }
    let!(:line_item) { FactoryBot.create(:line_item, order: order, widget: widget, quantity: 2) }
    let(:order_and_line_item_params) do
      {
        "order"=>
        {
          "line_items_attributes"=>
          {
            "#{line_item.id}"=>
            {
              "widget_id"=>"#{widget.id}", "quantity"=>"33", "unit_price"=>"12", "id" => "#{line_item.id}"
            }
          }
        }
      }
    end

    it 'should have the "Orders" title and order id on the page' do
      patch("/orders/#{order.id}", params: order_and_line_item_params)
      expect(line_item.reload.quantity).to eq(33)
    end
  end

  describe 'GET#show' do
    let(:order) { FactoryBot.create(:order)  }
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

  describe 'GET#edit' do
    let!(:order) { FactoryBot.create(:order) }
    let!(:widget) { FactoryBot.create(:widget, :cheap) }
    let!(:line_items) { FactoryBot.create_list(:line_item, 2, order: order, widget: widget) }
    it 'should return 2 line items and return a 200 status' do
      get "/orders/#{order.id}/edit"
      expect(count_line_items).to eq(2)
    end
  end

  describe 'GET#new' do
    let!(:order) { FactoryBot.create(:order) }
    it 'should return 1 line item row and return a 200 status' do
      get "/orders/new"
      expect(count_line_items).to eq(1)
    end
  end  

  def expect_to_create_an_order_with_1_line_item(&blk)
    expect(Order.count).to eq(0)
    expect(LineItem.count).to eq(0)
    yield
    expect(LineItem.count).to eq(1)
    expect(Order.count).to eq(1)
  end

  def count_line_items
    Nokogiri.parse(response.body).css(".line_item_form").count
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
