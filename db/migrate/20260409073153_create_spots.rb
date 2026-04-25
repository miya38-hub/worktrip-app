class CreateSpots < ActiveRecord::Migration[8.0]
  def change
    create_table :spots do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :category, null: false
      t.string :address
      t.float :latitude
      t.float :longitude
      t.boolean :wifi, default: false, null: false
      t.boolean :power_supply, default: false, null: false
      t.text :description

      t.timestamps
    end

    add_index :spots, :latitude
    add_index :spots, :longitude
  end
end