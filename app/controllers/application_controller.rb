class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  rescue_from Pundit::NotAuthorizedError, with: :handle_not_authorized

  def handle_not_authorized
    flash[:error] = t('notifications.not_authorized')
    redirect_to root_path
  end
end
