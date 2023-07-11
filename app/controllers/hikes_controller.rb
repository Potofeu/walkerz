class HikesController < ApplicationController
  before_action :set_hike, only: [:show, :edit, :update]
  skip_before_action :authenticate_user!, only: :index

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

  def new
    @hike = Hike.new
    @location = Location.new
    authorize @hike
  end

  def create
    @hike = Hike.new(hike_params)
    @hike.creator = current_user
    authorize @hike
    if @hike.save!
      @hike_categories = params[:hike][:category_ids]
      @hike_categories.each do |category|
        HikesCategory.create(hike_id: @hike.id, category_id: category.to_i)
      end
      redirect_to new_hike_location_path(@hike)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    authorize @hike

    @review = Review.new(hike: @hike)
    @sum = 0
    @hike.reviews.each do |review|
      @sum += review.rating
    end
    @average = @sum / @hike.reviews.size.to_f
  end

  def update
    @hike.update(hike_params)
    @hike_categories = params[:hike][:category_ids].reject(&:empty?)
    @hike.hikes_categories.destroy_all
    @hike_categories.each do |category|
      HikesCategory.create(hike_id: @hike.id, category_id: category.to_i)
    end
    redirect_to hike_path(@hike)
  end

  def edit
  end

  def destroy
    @hike = Hike.find(params[:id])
    authorize @hike
    @hike.destroy
    redirect_to my_hikes_path
  end

  private

  def hike_params
    params.require(:hike).permit(:name, :description, :time, :distance, :city)
  end

  def set_hike
    @hike = Hike.find(params[:id])
    authorize @hike
    # On récupère la liste des coordonnées pour les circuits
    @markers = @hike.locations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        marker_html: render_to_string(partial: "marker", locals: {location: location}),
        markerfullscreen_html: render_to_string(partial: "markerfullscreen", locals: {location: location})
      }
    end
  end
end
