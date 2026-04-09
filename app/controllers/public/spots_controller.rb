class Public::SpotsController < Public::ApplicationController
  before_action :require_authentication
  before_action :set_spot, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @spots = Spot.all
  end

  def show
    @user = current_user
    @spots = @user.spots
    @favorites = @user.favorites
    @reviews = @user.reviews
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = current_user.spots.build(spot_params)
    if @spot.save
      redirect_to @spot, notice: "投稿しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @spot.update(spot_params)
      redirect_to @spot, notice: "更新しました"
    else
      render :edit
    end
  end

  def destroy
    @spot.destroy
    redirect_to spots_path, notice: "削除しました"
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
