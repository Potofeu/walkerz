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

    respond_to do |format|
      if @favorite.save
        format.html {
          if request.referrer.include?("favorites")
            redirect_to favorites_path
          else
            redirect_to root_path
          end
        }
        format.json
      else
        format.html { render root_path, status: :unprocessable_entity }
        format.json
      end
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

    respond_to do |format|
      if @favorite.destroy
        format.html {
          if request.referrer.include?("favorites")
            redirect_to favorites_path, status: :see_other
          else
            redirect_to root_path
          end
        }
        format.json
      else
        format.html { render root_path, status: :unprocessable_entity }
        format.json
      end
    end
  end

  private

  def set_hike
    @hike = Hike.find(params[:hike_id])
  end

end
