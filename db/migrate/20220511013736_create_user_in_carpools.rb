class CreateUserInCarpools < ActiveRecord::Migration[6.0]
  def change
    create_table :user_in_carpools do |t|
      t.integer :user_id
      t.integer :carpool_id

      t.timestamps
    end
  end
end
