class Public::SpotsController < Public::ApplicationController
  before_action :require_authentication
  before_action :set_spot, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @spots = Spot.includes(:comments, :reviews).order(created_at: :desc).page(params[:page]).per(6)
  end

  def show
    @user = current_user
    @reviews = @spot.reviews.includes(:user)

    @comments = @spot.comments.includes(:user)
    @comment = Comment.new
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = current_user.spots.build(spot_params)
    if @spot.save
      if params[:review]
        review = current_user.reviews.new(
          spot: @spot,
          rating: params[:review][:rating],
          wifi_rating: params[:review][:wifi_rating],
          power_rating: params[:review][:power_rating],
          quietness_rating: params[:review][:quietness_rating],
          workability_rating: params[:review][:workability_rating],
          comment: params[:review][:comment]
        )

        if review.save
          Rails.logger.debug "レビュー保存成功"
        else
          Rails.logger.debug review.errors.full_messages
        end
      end

      redirect_to @spot, notice: "投稿しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
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
    params.require(:spot).permit(:name, :category, :address, :wifi, :power_supply, :description)
  end
end