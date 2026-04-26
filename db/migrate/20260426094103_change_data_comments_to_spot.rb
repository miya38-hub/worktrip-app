class ChangeDataCommentsToSpot < ActiveRecord::Migration[8.0]
  def change
    change_column :comments, :spot_id, :bigint
  end
end
