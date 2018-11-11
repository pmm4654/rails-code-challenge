require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  render_views
  describe '#index' do
    let!(:order) { Order.create! }
    subject { get :index }
    it { is_expected.to have_http_status(:ok) }
    it 'should have the "Orders" title and order id on the page' do       
      expect(subject.body).to include('Orders')
      expect(subject.body).to include("#{order.id}")
    end
  end

  describe '#show' do
    let(:order) { Order.create! }
    subject { get :show, params: { id: order.id } }
    it { is_expected.to have_http_status(:ok) }
  end
end
