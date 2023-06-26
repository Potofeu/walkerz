class LocationController < ApplicationController
  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to restaurant_path(@restaurant) }
        format.json # Follow the classic Rails flow and look for a create.json view
      else
        format.html { render "restaurants/show", status: :unprocessable_entity }
        format.json # Follow the classic Rails flow and look for a create.json view
      end
    end
  end

  private

  def location_params
    params.require(:location).permit(:name, :address)
  end
end
