class Public::SpotsController < Public::ApplicationController
  before_action :require_authentication
  before_action :set_spot, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @spots = Spot
      .with_counts
      .search_by_word(params[:word])
      .filter_by_category(params[:category])
      .filter_by_region(params[:region])
      .filter_by_wifi(params[:wifi])
      .filter_by_power(params[:power_supply])
      .sort_spots(params[:sort].presence)
      .page(params[:page])
      .per(6)
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

    # レビューを先に作る
    if params[:review].present? && params[:review][:rating].present?
      @review = current_user.reviews.new(
        spot: @spot,
        rating: params[:review][:rating],
        wifi_rating: params[:review][:wifi_rating],
        power_rating: params[:review][:power_rating],
        quietness_rating: params[:review][:quietness_rating],
        workability_rating: params[:review][:workability_rating],
        comment: params[:review][:comment]
      )
    end

    if @spot.valid? && (@review.nil? || @review.valid?)

      @spot.save!

      if @review.present?
        @review.spot = @spot
        @review.save!

        begin
          result = Language.get_data(@review.comment)
          @review.update_column(:score, result[:score])
        rescue => e
          Rails.logger.error("Language API Error: #{e.message}")
        end
      end

      redirect_to @spot, notice: "投稿しました"

    else
      if @review&.errors&.any?
        @review.errors.full_messages.each do |msg|
          @spot.errors.add(:base, msg)
        end
      end

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