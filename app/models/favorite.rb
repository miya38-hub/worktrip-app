class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :spot

  validates :user_id, uniqueness: { scope: :spot_id }

  scope :last_week, -> {
    where(created_at: 1.week.ago.beginning_of_day..Time.current.end_of_day)
  }

  def self.daily_counts
    group("DATE(created_at)").count
  end
end
