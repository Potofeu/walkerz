class LocationsController < ApplicationController
  def new
    @hike = Hike.find(params[:hike_id])
    @location = Location.new
    authorize @location
  end

  def create
    @location = Location.new
  end
end
