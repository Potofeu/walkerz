class FavoritesController < ApplicationController
  before_action :set_hike, only: %i[new create]

  def new
    @favorite = Favorite.new
    authorize @favorite
  end

  def create
    @favorite = Favorite.new
    @user = current_user
    authorize @favorite
    @favorite.hike = @hike
    @favorite.user = @user
    if @favorite.save
      redirect_to favorites_path
    else
      render root_path, status: :unprocessable_entity
    end
  end

  def index
    @favorites = policy_scope(Favorite)
    @user = current_user
    @favorites = @user.favorites
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    authorize @favorite
    @favorite.destroy
    redirect_to favorites_path, status: :see_other
  end

  private

  def set_hike
    @hike = Hike.find(params[:hike_id])
  end

end
