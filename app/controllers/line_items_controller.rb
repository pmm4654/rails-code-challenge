class LineItemsController < ApplicationController
  before_action :set_line_item, only: :destroy

  def destroy
    @line_item.destroy
  end

  def set_line_item
    @line_item = Order.find(params[:order_id]).line_items.find(params[:id])
  end
end