class Public::FavoritesController < Public::ApplicationController
  before_action :require_authentication

  def create
    spot = Spot.find(params[:spot_id])
    current_user.favorites.create(spot: spot)
    redirect_to spot_path(spot)
  end

  def destroy
    spot = Spot.find(params[:spot_id])
    current_user.favorites.find_by(spot: spot).destroy
    redirect_to spot_path(spot)
  end
end