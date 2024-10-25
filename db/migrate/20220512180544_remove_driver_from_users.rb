class RemoveDriverFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :driver, :boolean
  end
end
