class PointsOfInterestController < ApplicationController
  def update
    @poi = PointsOfInterest.find(params[:id])
    authorize @poi
    @poi.update(poi_params)
  end

  private

  def poi_params
    params.require(:points_of_interest).permit(:step)
  end
end
