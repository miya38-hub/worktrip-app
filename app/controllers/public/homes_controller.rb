class Public::HomesController < Public::ApplicationController
  allow_unauthenticated_access

  def top
  end

  def about
  end

  def dashboard
    @spots = Spot.limit(5)
  end
end
