class InactiveRecord

  def self.query(sql)
    ActiveRecord::Base.connection.exec_query(sql)
  end
end