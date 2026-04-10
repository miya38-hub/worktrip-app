class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :spot, null: false, foreign_key: true
      t.integer :rating
      t.integer :wifi_rating
      t.integer :power_rating
      t.integer :quietness_rating
      t.integer :workability_rating
      t.text :comment

      t.timestamps
    end
  end
end
