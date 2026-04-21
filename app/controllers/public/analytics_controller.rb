class Public::AnalyticsController < ApplicationController
  before_action :require_authentication

  def index
    # ===== パラメータ（期間切り替え）=====
    @range = params[:range] || "week"

    from, to = case @range
               when "day"
                 [1.day.ago.beginning_of_day, Time.current.end_of_day]
               when "month"
                 [1.month.ago.beginning_of_day, Time.current.end_of_day]
               else
                 [1.week.ago.beginning_of_day, Time.current.end_of_day]
               end

    # ===== 元データ取得（ユーザーに限定 + キーを文字列化🔥）=====
    favorite_hash = current_user.favorites
      .where(created_at: from..to)
      .group("DATE(created_at)")
      .count
      .transform_keys(&:to_s)

    spot_hash = current_user.spots
      .where(created_at: from..to)
      .group("DATE(created_at)")
      .count
      .transform_keys(&:to_s)

    # ===== 日付を揃える =====
    dates = (from.to_date..to.to_date).to_a

    @labels = dates.map(&:to_s)

    # ===== データ整形（0補完🔥）=====
    @favorite_data = dates.map { |date| favorite_hash[date.to_s] || 0 }
    @spot_data     = dates.map { |date| spot_hash[date.to_s] || 0 }

    # ===== 人気スポットランキング =====
    @popular_spots = Spot
      .joins(:favorites)
      .where(favorites: { created_at: from..to })
      .group("spots.id")
      .order("COUNT(favorites.id) DESC")
      .limit(5)

    # ===== カテゴリ別いいね数 =====
    @category_counts = Spot
      .joins(:favorites)
      .where(favorites: { created_at: from..to })
      .group(:category)
      .count
  end
end