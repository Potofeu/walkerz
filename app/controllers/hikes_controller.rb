class HikesController < ApplicationController
  before_action :set_hike, only: [:show, :edit, :update]

  def index
    @hikes = policy_scope(Hike)
    @user = current_user
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
    @review = Review.new(hike: @hike)
  end

  private

  def set_hike
    @hike = Hike.find(params[:id])
    authorize @hike
    # On récupère la liste des coordonnées pour les circuits
    @markers = @hike.locations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { location: location })
      }
    end
    @points = @hike.points_of_interests.order(step: :asc)
  end
end
