class HikesController < ApplicationController
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
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def hike_params
    params.require(:hike).permit(:name, :description, :time, :distance, :city)
  end
end
