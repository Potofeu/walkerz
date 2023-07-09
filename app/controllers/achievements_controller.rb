class AchievementsController < ApplicationController
  def index
    @user = current_user
    User.hikes_as_achievements.sum(:distance)
  end
end
