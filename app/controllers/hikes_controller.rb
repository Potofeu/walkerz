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
end
