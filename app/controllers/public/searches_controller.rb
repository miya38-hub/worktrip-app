class Public::SearchesController < Public::ApplicationController
  before_action :require_authentication

  def search
    @range = params[:range]
    @word = params[:word]
    @category = params[:category]
    @region = params[:region]
    @wifi = params[:wifi]
    @power_supply = params[:power_supply]

    if @range == "User"
      @users = search_users(@word).page(params[:page]).per(10)
    elsif @range == "Spot"
      @spots = search_spots(@word, @category, @region, @wifi, @power_supply)
                 .page(params[:page]).per(10)
    end
  end

  private

  # 🔥 ユーザー検索（部分一致のみ）
  def search_users(word)
    if word.present?
      User.where("name LIKE ?", "%#{escape_like(word)}%")
    else
      User.all
    end
  end

  # 🔥 スポット検索（部分一致のみ）
  def search_spots(word, category, region, wifi, power_supply)
    spots = Spot.all

    if word.present?
      spots = spots.where("name LIKE ?", "%#{escape_like(word)}%")
    end

    if category.present?
      spots = spots.where(category: category)
    end

    if region.present?
      spots = spots.where("address LIKE ?", "%#{escape_like(region)}%")
    end

    if wifi == "1"
      spots = spots.where(wifi: true)
    end

    if power_supply == "1"
      spots = spots.where(power_supply: true)
    end

    spots.order(created_at: :desc)
  end

  def escape_like(word)
    ActiveRecord::Base.sanitize_sql_like(word.to_s)
  end
end