class AddFromLocationToCarpools < ActiveRecord::Migration[6.0]
  def change
    add_column :carpools, :from_location, :string
  end
end
