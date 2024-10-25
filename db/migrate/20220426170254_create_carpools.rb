class CreateCarpools < ActiveRecord::Migration[6.0]
  def change
    create_table :carpools do |t|
      t.integer :driver_id
      t.string :from
      t.string :destination
      t.date :date
      t.string :time_of_departure
      t.integer :price
      t.integer :open_spots
      t.string :type_of_ride
      t.boolean :open_for_request

      t.timestamps
    end
  end
end
