class AddToLocationToCarpools < ActiveRecord::Migration[6.0]
  def change
    add_column :carpools, :to_location, :string
  end
end
