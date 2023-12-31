class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include Pundit::Authorization # ajoute les policies à toues les controllers
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

  protect_from_forgery prepend: true

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
