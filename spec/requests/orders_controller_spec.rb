require 'rails_helper'

RSpec.describe OrdersController, type: :request do
  describe '#index' do
    let!(:order) { Order.create! }
    it 'should have the "Orders" title and order id on the page' do 
      get '/orders'      
      expect(response.body).to include('Orders')
      expect(response.body).to include("#{order.id}")
    end
  end

  describe '#show' do
    let(:order) { Order.create! }
    it 'should show order details' do
      get "/orders/#{order.id}"
      expect(response.body).to include("Order #{order.id}")
    end
  end
end
