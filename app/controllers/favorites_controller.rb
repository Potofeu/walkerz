class FavoritesController < ApplicationController
  before_action :set_hike, only: [:new, :create]

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
      if request.referrer.include?("favorites")
        redirect_to favorites_path
      else
        redirect_to root_path
      end
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
    if request.referrer.include?("favorites")
      redirect_to favorites_path, status: :see_other
    else
      redirect_to root_path
    end
  end

  private

  def set_hike
    @hike = Hike.find(params[:hike_id])
  end

end
