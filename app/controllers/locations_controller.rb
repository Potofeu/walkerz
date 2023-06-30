require "open-uri"
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
    @location.photo.attach(io: File.open("db/images/Hiking_to_the_Ice_Lakes._San_Juan_National_Forest,_Colorado.jpg"), filename: "#{@location.name}.jpg")
    @hike = Hike.find(params[:hike_id])
    authorize @location

    if Location.exists?(address: @location.address)
      @existing_location = Location.find_by address: @location.address
      PointsOfInterest.create!(hike_id: @hike.id, location_id: @existing_location.id)
      redirect_to new_hike_location_path(@hike)
    else
      if @location.save!
        PointsOfInterest.create!(hike_id: @hike.id, location_id: @location.id)
        redirect_to new_hike_location_path(@hike)
      else
        render :new, statut: :unprocessable_entity
      end
    end
  end

  def location_params
    params.require(:location).permit(:name, :address)
  end
end
