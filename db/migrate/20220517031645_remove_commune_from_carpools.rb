class RemoveCommuneFromCarpools < ActiveRecord::Migration[6.0]
  def change
    remove_column :carpools, :commune, :string
  end
end
