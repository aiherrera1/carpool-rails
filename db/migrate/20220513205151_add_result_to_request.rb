class AddResultToRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :result, :string
  end
end
