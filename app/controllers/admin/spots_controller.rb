class Admin::SpotsController < Admin::ApplicationController
  before_action :require_admin
  before_action :set_spot, only: [:show, :edit, :update, :destroy]

  def index
    @spots = Spot.includes(:user, :reviews, :comments).order(created_at: :desc).page(params[:page]).per(10)
  end

  def create
    @spot = Spot.new(spot_params)

    if @spot.save
      redirect_to admin_spots_path, notice: "スポットを登録しました"
    else
      render :new
    end
  end

  def show
    @reviews = @spot.reviews.includes(:user)
    @comments = @spot.comments.includes(:user)
  end

  def edit
    @spot = Spot.find(params[:id])
  end

  def update
    if @spot.update(spot_params)
      redirect_to admin_spot_path(@spot), notice: "スポットを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @spot.destroy
    redirect_to admin_spots_path, notice: "スポットを削除しました"
  end

  private

  def set_spot
    @spot = Spot.find(params[:id])
  end

  def spot_params
    params.require(:spot).permit(:name, :category, :address, :wifi, :power_supply, :description)
  end
end