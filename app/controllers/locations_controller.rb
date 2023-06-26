class LocationsController < ApplicationController
  def index
    @locations = Location.all
  end
  def new
    @hike = Hike.find(params[:hike_id])
    @location = Location.new
    authorize @location
  end

  def create
    @location = Location.new(location_params)
    @hike = Hike.find(params[:hike_id])
    authorize @location

    if @location.save!
      redirect_to locations_path
    else
      render :new, statut: :unprocessable_entity
    end
  end

  def location_params
    params.require(:location).permit(:name, :address)
  end
end
