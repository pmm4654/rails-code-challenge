module LineItemsHelper

  def line_items_row_id(line_item)
    row_id = line_item.id || Time.now.to_s
    "line_item_#{row_id}"
  end

  def line_items_removal_class(line_item)
    return 'remove_new_line_item' if line_item.new_record?
    'remove_line_item'
  end

  def line_items_removal_link(line_item)
    return link_to('x', line_items_removal_url(line_item), class: line_items_removal_class(line_item)) if line_item.new_record?
    link_to 'x', order_line_item_path(order_id: line_item.order_id,  id: line_item.id), 
      class: line_items_removal_class(line_item), remote: true, method: :delete
  end

  def line_item_attributes_hidden_selector(line_item)
    "[id^=order_line_items_attributes][value=#{line_item.id}]"
  end

  private
  def line_items_removal_url(line_item)
    return '#' if line_item.new_record?
    order_line_item_path(order_id: line_item.order_id,  id: line_item.id)
  end

end