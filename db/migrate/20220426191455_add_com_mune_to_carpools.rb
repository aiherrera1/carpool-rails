class AddComMuneToCarpools < ActiveRecord::Migration[6.0]
  def change
    add_column :carpools, :commune, :string
  end
end
