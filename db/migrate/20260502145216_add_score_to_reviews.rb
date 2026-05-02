class AddScoreToReviews < ActiveRecord::Migration[8.0]
  def change
    add_column :reviews, :score, :decimal, precision: 3, scale: 2
  end
end
