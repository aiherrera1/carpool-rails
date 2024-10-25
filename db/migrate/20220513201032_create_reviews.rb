class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.integer :stars
      t.string :title
      t.string :comment
      t.string :type_of_review
      t.integer :carpool_id

      t.timestamps
    end
  end
end
