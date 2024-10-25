class AddUserIdToDriver < ActiveRecord::Migration[6.0]
  def change
    add_column :drivers, :user_id, :int
  end
end
