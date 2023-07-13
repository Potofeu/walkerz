class AchievementsController < ApplicationController
  def index
    @hikes = policy_scope(Hike)
    @user = current_user
    @total = 0
    @user.achievements.each do |achievement|
      @total += achievement.hike.distance
    end
  end

  def new
    @achievements = Achievement.new
    authorize @achievements
  end

  def create
    @achievement = Achievement.new(hike_id: params[:hike_id], user_id: current_user.id)
    authorize @achievement
    if @achievement.save!
      redirect_to achievements_path
    end
  end
end
