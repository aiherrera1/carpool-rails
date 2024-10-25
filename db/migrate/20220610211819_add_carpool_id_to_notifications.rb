class AddCarpoolIdToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :carpool_id, :integer
  end
end
