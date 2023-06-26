class HikesController < ApplicationController
  before_action :set_hike, only: [:show, :edit, :update]

  def index
    @hikes = policy_scope(Hike)
    @categories = Category.all
    if params[:latitude].present? && params[:longitude].present?
      latitude = params[:latitude].to_f
      longitude = params[:longitude].to_f
      @locations = Location.near([latitude, longitude], 100)
      @locations.each do |loc|
        @hikes = loc.hikes.uniq
      end
      # On va récupérer les circuits, et on enlève les doublons avec uniq
      # @hikes = @locations.hikes.uniq
    end
    if params[:query].present?
      # sql_subquery = "name ILIKE :query OR description ILIKE :query"
      @hikes = Hike.hike_search(params[:query])
      respond_to do |format|
        format.html { redirect_to hikes_path }
        # format.json { render json: @hikes }
        format.json
      end
    end
  end

  def show
    authorize @hike
  end

  private

  def set_hike
    @hike = Hike.find(params[:id])
  end
end
