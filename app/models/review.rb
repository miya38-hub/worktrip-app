class Review < ApplicationRecord
  belongs_to :user
  belongs_to :spot

  validates :user_id, uniqueness: { scope: :spot_id }
  validates :rating, presence: true

  validates :rating, :wifi_rating, :power_rating,
            :quietness_rating, :workability_rating,
            numericality: {in: 1..5}, allow_nil: true

  validate :check_bad_words

  private

  def check_bad_words
    bad_words = ["死ね", "バカ", "クソ", "殺す"]

    return if comment.blank?

    normalized = comment.gsub(/\s+/, "")

    if bad_words.any? { |word| normalized.include?(word) }
      errors.add(:base, "レビューに不適切な内容が含まれています")
    end
  end
end
