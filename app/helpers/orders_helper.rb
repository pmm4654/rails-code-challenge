module OrdersHelper
  
  def order_table_id(shipped)
    return 'shipped_orders' if shipped
    'unshipped_orders'
  end

  def order_table_name(shipped)
    return t('orders.shipped_orders') if shipped
    t('orders.unshipped_orders')
  end

  def order_status_link_text(order, setting)
    t("orders.settings.#{setting}")
  end

end