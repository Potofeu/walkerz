class PointsOfInterestController < ApplicationController
  def new
    @point_of_interest = PointsOfInterest.new
    authorize @point_of_interest
    @locations = Hike.order(name: :desc)
    if params[:query].present?
      @locations = locations.where('name ILIKE?', "%#{params[:query]}%")
    end
  end
end
