require 'rails_helper'

RSpec.describe LineItemsController, type: :request do
  
  describe 'DELETE#destroy' do
    let(:widget) { FactoryBot.create(:widget, :cheap) }
    let!(:order) { FactoryBot.create(:order) }
    let!(:line_item) { FactoryBot.create(:line_item, order: order, widget: widget) }

    it 'should have the "Orders" title and order id on the page' do 
      expect { delete "/orders/#{order.id}/line_items/#{line_item.id}.js" }.to change { LineItem.count }.from(1).to(0)
    end
  end

end
