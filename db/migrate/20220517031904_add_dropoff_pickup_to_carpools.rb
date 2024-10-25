class AddDropoffPickupToCarpools < ActiveRecord::Migration[6.0]
  def change
    add_column :carpools, :dropoff_pickup, :string
  end
end
