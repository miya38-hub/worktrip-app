class Admin::ReviewsController < Admin::ApplicationController
  before_action :require_admin
  before_action :set_spot, only: [:edit, :update, :destroy]
  before_action :set_review, only: [:edit, :update, :destroy]

  def index
    @reviews = Review.includes(:user, :spot)
                 .order(created_at: :desc)
                 .page(params[:page]).per(10)
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to admin_spot_reviews_path(@spot), notice: "レビューを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to admin_spot_reviews_path(@spot), notice: "レビューを削除しました"
  end

  private

  def set_spot
    @spot = Spot.find(params[:spot_id])
  end

  def set_review
    @review = @spot.reviews.find(params[:id])
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
end