class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :carpool_id
      t.string :message_text

      t.timestamps
    end
  end
end
