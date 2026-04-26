class ChangeDataCommentsToSpot < ActiveRecord::Migration[8.0]
  def change
    change_column :comments, :spot_id, :bigint,  null: false
    change_column :comments, :user_id, :bigint,  null: false
    change_column :favorites, :spot_id, :bigint,  null: false
    change_column :favorites, :user_id, :bigint,  null: false
    change_column :reviews, :spot_id, :bigint,  null: false
    change_column :reviews, :user_id, :bigint,  null: false
    change_column :sessions, :user_id, :bigint,  null: false
    change_column :spots, :user_id, :bigint,  null: false
  end
end
