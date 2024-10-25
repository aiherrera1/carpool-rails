class RemoveFromFromCarpools < ActiveRecord::Migration[6.0]
  def change
    remove_column :carpools, :from, :string
  end
end
