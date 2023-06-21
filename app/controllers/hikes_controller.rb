class HikesController < ApplicationController
  def index
    @hikes = policy_scope(Hike)
    @categories = Category.all
    if params[:query].present?
      # sql_subquery = "name ILIKE :query OR description ILIKE :query"
      @hikes = Hike.hike_search(params[:query])
      respond_to do |format|
        format.html { redirect_to hikes_path }
        format.json
      end
    end
  end
end
