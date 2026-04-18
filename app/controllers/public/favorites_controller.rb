class Public::FavoritesController < Public::ApplicationController
  before_action :require_authentication

  def create
    @spot = Spot.find(params[:spot_id])
    current_user.favorites.create(spot: @spot)

    @spot.reload
    @favorited = true

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: spot_path(@spot) }
    end
  end

  def destroy
    @spot = Spot.find(params[:spot_id])
    current_user.favorites.where(spot: @spot).destroy_all

    @spot.reload
    @favorited = false

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: spot_path(@spot) }
    end
  end
end