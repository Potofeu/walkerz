class AchievementsController < ApplicationController
  def index
    @hikes = policy_scope(Hike)
    @user = current_user
    @total = 0
    @user.achievements.each do |achievement|
      @total += achievement.hike.distance
    end
  end
end
