class AddDriverLicenseNumberToDriver < ActiveRecord::Migration[6.0]
  def change
    add_column :drivers, :driver_license_number, :string
  end
end
