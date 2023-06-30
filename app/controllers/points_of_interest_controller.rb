class PointsOfInterestController < ApplicationController
  def update
    @poi = PointsOfInterest.find(params[:id])
    authorize @poi
    @poi.update(poi_params)
    @hike = Hike.find(@poi.hike_id)
    redirect_to new_location_path(@hike)
  end

  private

  def poi_params
    params.require(:points_of_interest).permit(:step)
  end
end
