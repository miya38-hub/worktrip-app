class Public::ReviewsController < Public::ApplicationController
  before_action :require_authentication
  before_action :set_spot
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :check_review_permission, only: [:create]


  def index
    @reviews = Review.includes(:user, :spot)
                     .order(created_at: :desc)
                     .page(params[:page]).per(10)
  end

  def new
    @spot = Spot.find(params[:spot_id])
    @review = Review.new
  end

  def create

    @review = current_user.reviews.new(
      review_params.merge(spot: @spot)
    )
    if @review.save
      redirect_to spot_path(@spot), notice: "レビューを投稿しました"
    else
      @reviews = @spot.reviews.includes(:user)
      @comments = @spot.comments.includes(:user)
      @comment = Comment.new
      render "public/spots/show", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to spot_path(@spot), notice: "レビューを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to spot_path(@spot), notice: "レビューを削除しました"
  end

  private

  def set_spot
    @spot = Spot.find(params[:spot_id])
  end

  def set_review
    @review = @spot.reviews.find(params[:id])
  end

  def ensure_correct_user
    unless @review.user == current_user
      redirect_to spot_path(@spot), alert: "権限がありません"
    end
  end

  def review_params
    params.require(:review).permit(
      :rating,
      :wifi_rating,
      :power_rating,
      :quietness_rating,
      :workability_rating,
      :comment
    )
  end

  def check_review_permission
    # 投稿者はNG
    if current_user == @spot.user
      redirect_to spot_path(@spot), alert: "投稿者はレビューできません"
      return
    end

    # すでにレビュー済みはNG
    if current_user.reviews.exists?(spot: @spot)
      redirect_to spot_path(@spot), alert: "すでにレビュー済みです"
    end
  end
end