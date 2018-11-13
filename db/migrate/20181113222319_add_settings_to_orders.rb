class AddSettingsToOrders < ActiveRecord::Migration[5.2]
  # enable_extension 'hstore' unless extension_enabled?('hstore')
  def change
    add_column :orders, :settings, :json, default: {}
  end

  def remove
    remove_column :orders, :settings
  end
end
