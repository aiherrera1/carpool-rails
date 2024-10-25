class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.string :comment

      t.timestamps
    end
  end
end
