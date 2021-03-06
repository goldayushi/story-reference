# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper
  helper_method :admin_user?, :logged_in?

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  private

  def render_404
    render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  end

  def logged_in_user
    redirect_to login_path unless logged_in?
  end

  def admin_user?
    return @current_user.admin unless @current_user.nil?
  end

  def not_admin_user
    redirect_to root_path unless admin_user?
  end
end
