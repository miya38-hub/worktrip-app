class ChangeDataCommentsToSpot < ActiveRecord::Migration[8.0]
  def change
    change_column :comments, :spot_id, :bigint,  null: false
    change_column :comments, :user_id, :bigint,  null: false
  end
end
