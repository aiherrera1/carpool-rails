class AddLicensePlateToDriver < ActiveRecord::Migration[6.0]
  def change
    add_column :drivers, :license_plate, :string
  end
end
