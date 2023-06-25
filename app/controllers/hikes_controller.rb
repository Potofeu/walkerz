class HikesController < ApplicationController
  def index
    @hikes = policy_scope(Hike)
    if params[:query].present?
      # sql_subquery = "name ILIKE :query OR description ILIKE :query"
      sql_subquery = <<~SQL
        hikes.name ILIKE :query
        OR hikes.description ILIKE :query
        OR categories.name ILIKE :query
      SQL
      # @hikes = @hikes.where(sql_subquery, query: "%#{params[:query]}%")
      @hikes = @hikes.joins(:categories).where(sql_subquery, query: "%#{params[:query]}%")

      respond_to do |format|
        format.html
        format.json { render json: @hikes }
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
