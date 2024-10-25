class AddCarDescriptionToDrivers < ActiveRecord::Migration[6.0]
  def change
    add_column :drivers, :car_description, :string
  end
end
