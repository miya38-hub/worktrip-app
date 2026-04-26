class Public::SpotsController < Public::ApplicationController
  before_action :require_authentication
  before_action :set_spot, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @spots = Spot.left_joins(:favorites, :comments)
      .select("
        spots.*,
        COUNT(DISTINCT favorites.id) AS favorites_count,
        COUNT(DISTINCT comments.id) AS comments_count
      ")
      .group("spots.id")

    # 🔍 キーワード検索
    if params[:word].present?
      @spots = @spots.where("spots.name LIKE ?", "%#{params[:word]}%")
    end

    # 🔍 カテゴリ
    if params[:category].present?
      @spots = @spots.where(category: params[:category])
    end

    # 🔍 地域
    if params[:region].present?
      @spots = @spots.where("spots.address LIKE ?", "%#{params[:region]}%")
    end

    # 🔍 WiFi
    if params[:wifi].present?
      @spots = @spots.where(wifi: params[:wifi] == "1")
    end

    # 🔍 電源
    if params[:power_supply].present?
      @spots = @spots.where(power_supply: params[:power_supply] == "1")
    end

    # 🔥 並び替え（ここ追加）
    case params[:sort]
    when "favorites"
      @spots = @spots.order("favorites_count DESC")
    when "comments"
      @spots = @spots.order("comments_count DESC")
    else
      @spots = @spots.order(created_at: :desc)
    end

    @spots = @spots.page(params[:page]).per(6)
  end

  def show
    @spot = Spot.find(params[:id])

    @user = current_user
    @reviews = @spot.reviews.includes(:user).order(created_at: :desc)

    @comments = @spot.comments.includes(:user).order(created_at: :desc)
    @comment = Comment.new
    @favorited = Favorite.exists?(user_id: current_user.id, spot_id: @spot.id)
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = current_user.spots.build(spot_params)

    if @spot.save

      # レビュー保存
      if params[:review].present? && params[:review][:rating].present?
        review = current_user.reviews.new(
          spot: @spot,
          rating: params[:review][:rating],
          wifi_rating: params[:review][:wifi_rating],
          power_rating: params[:review][:power_rating],
          quietness_rating: params[:review][:quietness_rating],
          workability_rating: params[:review][:workability_rating],
          comment: params[:review][:comment]
        )

        unless review.save
          Rails.logger.debug review.errors.full_messages
        end
      end

      # ← ここが今回追加する正しい位置
      @spot.geocode
      @spot.save

      redirect_to @spot, notice: "投稿しました"

    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @spot = Spot.find(params[:id])
  end

  def update
    if @spot.update(spot_params)
      redirect_to @spot, notice: "更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @spot.destroy
    redirect_to user_path(current_user), notice: "削除しました"
  end

  private

  def set_spot
    @spot = Spot.find(params[:id])
  end

  def correct_user
    unless @spot.user == current_user
      redirect_to spots_path, alert: "権限がありません"
    end
  end

  def spot_params
    params.require(:spot).permit(:name, :category, :address, :postal_code, :wifi, :power_supply, :description)
  end
end