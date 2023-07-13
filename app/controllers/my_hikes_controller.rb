class MyHikesController < ApplicationController
  def index
    @hikes = policy_scope(Hike)
    @myhikes = current_user.hikes
  end

  def show
    @myhikes = Flat.find(params[:id])
    authorize @myhikes
  end
end
