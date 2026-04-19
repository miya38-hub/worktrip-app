class MapsController < ApplicationController
  def show
    @spots = Spot.all
  end
end