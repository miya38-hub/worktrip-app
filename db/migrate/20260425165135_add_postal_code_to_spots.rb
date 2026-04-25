class AddPostalCodeToSpots < ActiveRecord::Migration[8.0]
  def change
    add_column :spots, :postal_code, :string
  end
end
