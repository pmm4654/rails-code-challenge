class OrdersController < ApplicationController
  
  before_action :set_order, only: [:new, :add_line_item, :show, :create, :update ]

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order.line_items.build
  end

  def add_line_item
    @order.line_items.build
  end

  def edit
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to @order, notice: t('orders.create_success_flash_notification')
    else
      render :new
    end
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: t('orders.update_success_flash_notification')
    else
      render :edit
    end
  end

  private

  def set_order
    @order = params[:id] ? Order.find(params[:id]) : Order.new
  end

  def order_params
    params.require(:order).permit(
      :line_items_attributes => %i(id order_id widget_id quantity unit_price)
    )
  end

end
