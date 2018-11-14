class Order < ApplicationRecord
  has_many :line_items
  accepts_nested_attributes_for :line_items, allow_destroy: true

  scope :shipped, -> (direction = :desc) { where.not(shipped_at: nil).order(shipped_at: direction) }
  scope :unshipped, -> { where(shipped_at: nil) }


  SETTING_ACCESSOR_WHITELIST = %i[expedite returns warehouse]

  store_accessor :settings, SETTING_ACCESSOR_WHITELIST
  def expedited?
    !!expedite
  end

  def returnable?
    !!returns
  end

  def update_settings!(type, value)
    send("#{type}=", value) if valid_setting?(type)
    save
  end

  def ship!
    self.shipped_at = DateTime.now
    save
  end

  def shipped?
    shipped_at.present?
  end

  def warehoused?
    !!warehouse
  end

  private
  def valid_setting?(type)
    SETTING_ACCESSOR_WHITELIST.include?(type.to_sym)
  end

end

