class RemoveDestinationFromCarpools < ActiveRecord::Migration[6.0]
  def change
    remove_column :carpools, :destination, :string
  end
end
