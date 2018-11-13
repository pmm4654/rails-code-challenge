class Widget < ApplicationRecord
  has_many :line_items, dependent: :destroy


  def self.select_options
    widget_options_sql = 
    <<-QUERY
      select CONCAT(name, ' (', 'MSRP: ', msrp, ')') as widget_option, id
      from widgets
    QUERY
    InactiveRecord.query(widget_options_sql).rows
  end
end
