class CreateSpots < ActiveRecord::Migration[8.0]
  def change
    create_table :spots do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :category
      t.string :address
      t.float :latitude
      t.float :longitude
      t.boolean :wifi
      t.boolean :power_supply
      t.text :description

      t.timestamps
    end
  end
end
